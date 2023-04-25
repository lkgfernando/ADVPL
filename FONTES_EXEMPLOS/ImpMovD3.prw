#Include "Totvs.ch"
#DEFINE ENTER Chr(13)+Chr(10)

/*/{Protheus.doc} ImpMovD3
@description 	Importacao de movimentação interna (Específico)
@author 		Paulo Bindo
@version		1.0
@param			Nil
@return			Nil
@type 			Function
/*/
User Function ImpMovD3()
	Local aParam   	:=	{Space(70)}
	Local aPerg		:= 	{}
	Local aRet		:= 	{}
	Local aLido		:=	{}

	Aadd( aPerg, { 6,"Arquivo a Importar"		, aParam[01]			,""	,".T."	,"!Empty(MV_PAR01)"	,70	,.T.,"Arquivos .CSV |*.CSV"	} )

	If ParamBox( aPerg, "Importação de custo", @aRet )

		//Leitura do Arquivo
		FwMsgRun( ,{|| LeArquivo( aRet[1], @aLido ) }, , "Lendo arquivo, por favor aguarde")

		//Processamento
		If Len( aLido ) > 0
			If MsgYesNo( "Existe(m) " + Alltrim(Str( Len(aLido) )) + " registros no arquivo, deseja importar" )
				Processa( {|| ProcD3( aLido, aRet ) }, "Lançando movimentações, Por favor aguarde." )
			EndIf
		EndIf

	EndIf

Return Nil

/*/{Protheus.doc} LeArquivo
@description 	Leitura do arquivo de Inventario
@author 		Paulo Bindo
@version		1.0
@type 			Function
/*/
Static Function LeArquivo( cArquivo, aLido )
	Local aTemp		:= {}
	Local cBuffer	:= ""
	Local nCount 	:= 0
	Local nErros    := 0
	Local lErro   	:= .F.
	Local cErro :=  "Foram encontrados erros, as linhas abaixo não serão importadadas, deseja continuar?" +ENTER

	FT_FUse( cArquivo )
	FT_FGoTop()

	While !FT_FEOF()
		nCount ++
		cBuffer	:= FT_FREADLN()
		aTemp 	:= StrToKarr( cBuffer, ";" )
		aAux	:= Array( 09 )

		If Len( aTemp ) < 6
			cErro += cValToChar(nCount)+Iif(nErros == 10,ENTER,"/")
			If nErros == 10
				nErros := 0
			else
				nErros++
			EndIf
			lErro := .T.
		Else
			//NAO IMPORTA A LINHA QUANDO FOR A LINHA COM O NOME DOS CAMPOS
			If !IsAlpha( aTemp[1]  )
				aAux[1]	:= aTemp[1]			//FILIAL
				aAux[2]	:= aTemp[2]			//PRODUTO
				aAux[3]	:= Iif(IsAlpha( aTemp[3] ), aTemp[3], StrZero(Val(aTemp[3]),2)) //LOCAL
				aAux[4]	:= aTemp[4]					//DOC
				aAux[5] := aTemp[5]			//EMISSAO
				aAux[6]	:= aTemp[6]			//CUSTO 1
				/*
				aAux[7]	:= aTemp[7]			//CUSTO 2
				aAux[8]	:= aTemp[8]			//CUSTO 3
				aAux[9]	:= aTemp[9]			//CUSTO 4
*/
				Aadd( aLido, aAux )
			EndIf
		EndIf

		FT_FSkip()

	End

//EXIBE TELA DE ERROS
	If lErro
		If !MsgYesNo(cErro)
			Return
		EndIf
	EndIf


Return Nil

/*/{Protheus.doc} ProcD3
@description 	Lança movimentacao 
@author 		Paulo Bindo
@version		1.0
@type 			Function
/*/
Static Function ProcD3( aLido, aRet )
	Local cFilD3	:= ""
	Local cProduto	:= ""
	Local cLocal	:= ""
	Local cDoc		:= ""
	Local dEmissao	:= Ctod("")
	Local nCusto1	:= 0
	Local nCusto2	:= 0
	Local nCusto3	:= 0
	Local nCusto4	:= 0
	Local lErro		:= .F.
	Local cTMN    	:= GETNEWPAR("FL_MOVN", "011")	//VALOR NEGATIVO
	Local cTMP    	:= GETNEWPAR("FL_MOVP", "511")  //VALOR POSITIVO
	Local cTmD3		:= ""
	Local cMensagem	:= ""
	Local aDados	:= {}
	Local aLogs		:= {}
	Local nX		:= 0
	Local _aCabArrSai   := {}
	Local _aTotItSai 	:= {}
	Local dDataUlMes := SuperGetMv( 'MV_ULMES' )
	Local cTmAnt	:= ""
	Private lMSErroAuto	:= .F.

	ProcRegua( Len( aLido ) )
	aLido := 	ASORT(aLido, , , { | x,y | x[1]+ x[4] < y[1]+y[4] } )

	For nX := 1 To Len( aLido )

		aDados		:= {}
		lErro		:= .F.
		cLinha		:= Alltrim( Str( nX ) )
		cFilD3		:= PadL( aLido[nX][1], TamSx3("D3_FILIAL")[1] ,"0")
		cProduto	:= PadR( aLido[nX][2], TamSx3("D3_COD")[1] )
		cLocal		:= PadR( aLido[nX][3], TamSx3("D3_LOCAL")[1] )
		cDoc		:= PadR( aLido[nX][4], TamSx3("D3_DOC")[1] )
		dEmissao	:= Stod(aLido[nX][5])

		//VALIDA A DATA
		If dEmissao < dDataUlMes .Or. dEmissao > dDataBase
			Help( ,, 'Erro data',, 'Verifique se existe uma data menor que a data do fechamento ou uma data maior que a data do sistema', 1, 0)
			Return
		EndIf

		//valida a filial
		If cFilD3 <> cFilAnt
			cMensagem	:= "Produto " + Alltrim( cProduto ) + " com filial incorreta "+cFilD3
			lErro := .T.
			//Adiciona LOG
			Aadd( aLogs,	{lErro, "Linha " + cLinha,	cMensagem} )
		Else
			dbSelectArea("SB2")
			dbSetOrder(1)
			If dbSeek(xFilial()+cProduto+cLocal)
				nValor1 := Val( StrTran(StrTran(aLido[nX][6],".",""),",",".") )*SB2->B2_QATU //NOVO CUSTO TOTAL
				nCusto1 := (SB2->B2_QATU * SB2->B2_CM1) //TOTAL CUSTO MEDIO ATUAL

				nValor2	:= xMoeda( nValor1,1,2,dEmissao)
				nCusto2 := (SB2->B2_QATU * SB2->B2_CM2) //TOTAL CUSTO MEDIO ATUAL

				nValor3	:= xMoeda( nValor1,1,3,dEmissao)
				nCusto3 := (SB2->B2_QATU * SB2->B2_CM3) //TOTAL CUSTO MEDIO ATUAL

				nValor4	:= xMoeda( nValor1,1,4,dEmissao)
				nCusto4 := (SB2->B2_QATU * SB2->B2_CM4) //TOTAL CUSTO MEDIO ATUAL

				//AJUSTA CUSTO 1
				If nCusto1 > nValor1
					nCusto1 := nCusto1 - nValor1
					cTmD3 := cTMP
				elseIf nCusto1 < nValor1
					nCusto1 := nValor1 - nCusto1
					cTmD3 := cTMN
				else //IGUAL
					nCusto1 := nValor1
					cTmD3 := cTMP
				EndIf

				//AJUSTA CUSTO 2
				If nCusto2 > nValor2
					nCusto2 := nCusto2 - nValor2
				elseIf nCusto2 < nValor2
					nCusto2 := nValor2 - nCusto2
				else //IGUAL
					nCusto2 := nValor2
				EndIf

				//AJUSTA CUSTO 3
				If nCusto3 > nValor3
					nCusto3 := nCusto3 - nValor3
				elseIf nCusto3 < nValor3
					nCusto3 := nValor3 - nCusto3
				else //IGUAL
					nCusto3 := nValor3
				EndIf

				//AJUSTA CUSTO 4
				If nCusto4 > nValor4
					nCusto4 := nCusto4 - nValor4
				elseIf nCusto4 < nValor4
					nCusto4 := nValor4 - nCusto4
				else //IGUAL
					nCusto4 := nValor4
				EndIf



				//MONTA O CABECALHO
				if Len(_aCabArrSai) == 0
					AADD(_aCabArrSai, {"D3_DOC"     , cDoc								, NIL} )
					AADD(_aCabArrSai, {"D3_TM"      , cTmD3                             , NIL} )
					AADD(_aCabArrSai, {"D3_CC"      , "        "                        , NIL} )
					AADD(_aCabArrSai, {"D3_EMISSAO" , dEmissao                         	, NIL} )
				EndIf


				IncProc( "Lançando produto: " + cProduto)
				ProcessMessage() // FORÇA O DESCONGELAMENTO DO SMARTCLIENT

				DbSelectarea("SB1")
				SB1->( DbSetorder(1) )
				If SB1->( DbSeek(xFilial("SB1") + cProduto) )
					//cUM := SB1->B1_UM
					cConta := SB1->B1_CONTA
					If SB1->B1_MSBLQL # "1"
						Aadd( aDados,	{ "D3_COD"   	, cProduto  			, Nil	})
						//AADD( aDados,	{ "D3_UM"       , cUM      		        ,NIL	})
						AADD( aDados,	{ "D3_QUANT"    , 0       		        ,NIL	})
						Aadd( aDados,	{ "D3_CONTA" 	, cConta  				, Nil	})
						Aadd( aDados,	{ "D3_LOCAL" 	, cLocal  				, Nil	})
						Aadd( aDados,	{ "D3_CUSTO1"	, nCusto1				, Nil	})
						Aadd( aDados,	{ "D3_CUSTO2"	, nCusto2				, Nil	})
						Aadd( aDados,	{ "D3_CUSTO3"	, nCusto3				, Nil	})
						Aadd( aDados,	{ "D3_CUSTO4"	, nCusto4				, Nil	})

						aadd(_aTotItSai, aDados)
					EndIf
				else
					cMensagem	:= "Produto " + Alltrim( cProduto ) + " bloqueado para uso"
					lErro := .T.
					//Adiciona LOG
					Aadd( aLogs,	{lErro, "Linha " + cLinha,	cMensagem} )
				EndIf



				//VALIDA O PROXIMO DOC
				If nX == Len(aLido)
					cProxDoc := ""
				else
					cProxDoc := PadR( aLido[nX+1][4], TamSx3("D3_DOC")[1] )
				EndIf

				//EXECUTA A ROTINA AUTOMATICA
				If Len(_aCabArrSai) > 0 .And. Len(_aTotItSai) > 0 .And. (cDoc # cProxDoc .Or. cTmAnt # cTmD3)

					lMSErroAuto	:= .F.

					MSExecAuto({|x,y,z| MATA241(x,y,z)},_aCabArrSai,_aTotItSai,3)

					If lMsErroAuto
						lErro 		:= .T.
						cMensagem	:= "Produto " + Alltrim( cProduto ) + CRLF
						cMensagem	+= MostraErro( "\", "ImpMovD3.LOG" )
					EndIf


					If !lErro
						cMensagem	:= "Produto " + Alltrim( cProduto ) + " Importado com sucesso"
					EndIf

					//Adiciona LOG
					Aadd( aLogs,	{lErro, "Linha " + cLinha,	cMensagem} )
					_aCabArrSai := {}
					_aTotItSai := {}


				Endif
			else
				cMensagem	:= "Produto " + Alltrim( cProduto ) + " não localizado na SB2 - local "+cLocal
				lErro := .T.
				//Adiciona LOG
				Aadd( aLogs,	{lErro, "Linha " + cLinha,	cMensagem} )
			EndIf
			cTmAnt	:= cTmD3
		EndIf
	Next nX

	If Len( aLogs ) > 0
		MostraLog( aLogs )
	EndIf

Return Nil

/*/{Protheus.doc} MostraLog
@description 	Mostra Log de processamento 
@author 		Paulo Bindo
@version		1.0
@type 			Function
/*/
Static Function MostraLog( aLogs )
	Local oFontL 	:= TFont():New("Mono AS",,012,,.T.,,,,,.F.,.F.)
	Local cMask    	:= "Arquivos Texto" + "(*.TXT)|*.txt|"
	Local cMemo		:= ""
	Local cFile    	:= ""
	//Local cTexto   	:= ""
	Local oBtnSair
	Local oGrpLog
	Local oPanelB
	Local oMemo
	Local oDlgLog

	DEFINE MSDIALOG oDlgLog TITLE "Log de Processamento" FROM 000, 000  TO 400, 700 COLORS 0, 16777215 PIXEL

	@ 182, 000 MSPANEL oPanelB SIZE 350, 017 OF oDlgLog COLORS 0, 16777215 RAISED
	oPanelB:Align	:= CONTROL_ALIGN_BOTTOM

	@ 002, 002 LISTBOX oLogs Fields HEADER "","Linha do Arquivo" SIZE 100, 176 OF oDlgLog PIXEL ColSizes 50,50
	oLogs:SetArray(aLogs)
	oLogs:bChange	:= {|| 	cMemo := aLogs[oLogs:nAt,3], oMemo:Refresh() }
	oLogs:bLine		:= {||	{;
		IF( aLogs[oLogs:nAt,1], LoadBitmap( GetResources(), "BR_VERMELHO" ), LoadBitmap( GetResources(), "BR_VERDE" ) ),;
			aLogs[oLogs:nAt,2];
			}}

		@ 001, 105 GROUP oGrpLog TO 178, 350 PROMPT " Log do Processamento " OF oDlgLog COLOR 0, 16777215 PIXEL

		@ 009, 107 GET oMemo VAR cMemo OF oDlgLog MULTILINE SIZE 240, 166 COLORS 0, 16777215 HSCROLL PIXEL Font oFontL

		DEFINE SBUTTON oBtnSair	FROM 185, 150 TYPE 01 OF oDlgLog ENABLE Action( oDlgLog:End() )
		DEFINE SBUTTON oBtnSave	FROM 185, 180 TYPE 13 OF oDlgLog ENABLE Action( cFile := cGetFile( cMask, "" ), If( Empty(cFile), .T., GrvLog( aLogs, cFile ) ) )

		ACTIVATE MSDIALOG oDlgLog CENTERED

		Return Nil

/*/{Protheus.doc} GrvLog
@description 	Grava LOG em arquivo  
@author 		Paulo Bindo
@version		1.0
@type 			Function
/*/
Static Function GrvLog( aLogs, cFile )
	Local nHandle	:= MsfCreate( cFile,0 )
	Local cTexto	:= ""
	Local nX		:= 0

	If nHandle <= 0
		MsgInfo("Não foi possível criar o arquivo, verifique")
		Return Nil
	Endif

	//Gera o Arquivo Tabulado
	For nX := 1 To Len( aLogs )

		//Armazena Loc
		cTexto := "Linha: " + aLogs[nX][02] + Space( 5 ) + aLogs[nX][03]

		//Grava Linha
		FWrite( nHandle, cTexto + CRLF )

	Next nX

	FClose(nHandle)

	MsgInfo( "Arquivo " + Alltrim( cFile ) + " gravado com sucesso" )

Return Nil

