#Include "Totvs.ch"

/*==========================================================================
 Funcao...........:	ExpUsrWo
 Descricao........:	Exportacao de permissoes de Usuarios para Formulario
 					Word (.DOT)
 Autor............:	Amedeo D. Paoli Filho
 					Fabrica de Software - FABRITECH
 					
 Data.............:	25/04/2014
 Parametros.......:	Nil
 Retorno..........:	Nil
==========================================================================*/
User Function ExpUsrWo()
	Local aSays		:= {}
	Local aButtons	:= {}

	Aadd( aSays,	"Essa Rotina tem o Objetivo de Gerar em arquivo .DOC"	)
	Aadd( aSays,	"As permissões dos usuários cadastrados no sistema "	)

	Aadd( aButtons, { 1,.T.,	{ |oDlg| VerRange(), oDlg:oWnd:End() }}	)
	Aadd( aButtons, { 2,.T.,	{ |oDlg| oDlg:oWnd:End() }} 				)

	FormBatch("Exportação de Permissão de Usuários", aSays, aButtons,,200,405 )

Return Nil

/*==========================================================================
 Funcao...........:	VerRange
 Descricao........:	Parametro dos usuarios a serem gerados
 Autor............:	Amedeo D. Paoli Filho
==========================================================================*/
Static Function VerRange()
	Local aParamBox := {}
	Local aRet 		:= {}
	Local aUsuarios	:= {}
	Local aParam	:= { Space( Len(__cUserID) ), Space( 60 ) }
	Local oProcess	:= Nil
	
	Aadd(aParamBox 	,{1,"Usuário de"			,aParam[01]	,""	,"","USR"	,"",0	,.T.})
	Aadd(aParamBox 	,{1,"Usuário Até"			,aParam[01]	,""	,"","USR"	,"",0	,.T.})
	Aadd(aParamBox	,{6,"Caminho dos arquivos"	,aParam[02],"",".T.","!Empty(MV_PAR03)",80,.T.," |*.","C:\",GETF_RETDIRECTORY+GETF_LOCALHARD,.F.})
	Aadd(aParamBox	,{3,"Imprime Bloqueados"	,1,{"Sim","Não"},50,"",.F.})

	If ParamBox(aParamBox,"",@aRet)
		
		FwMsgRun(,{|| aUsuarios := FWSFALLUSERS() }, , "Lendo cadastro de usuários, Por favor Aguarde" )

		oProcess := MsNewProcess():New({|| GeraArq( aUsuarios, aRet[1], aRet[2], aRet[3], aRet[4], oProcess ) },"Em processamento","Por favor aguarde",.T.)
		oProcess:Activate()
		
	EndIf
	
Return Nil

/*==========================================================================
 Funcao...........:	GeraArq
 Descricao........:	Gera Arquivos
 Autor............:	Amedeo D. Paoli Filho
==========================================================================*/
Static Function GeraArq( aUsuarios, cUserDe, cUserAte, cPathLoc, nBloqueio, oObjReg )
	Local cPathSrv	:= SuperGetMV("FB_DOCSACE", Nil, "\DOTS\")
	Local cArqDOT	:= SuperGetMV("FB_DOTACE", Nil, "Caduser.dot")
	Local aEmpSM0	:= GetFil()
	Local cVerProt	:= GetVersao(.F.)
	Local cArquivo	:= ""
	Local cArqNew	:= ""
	Local aImprime	:= {}
	Local aModulos	:= {}
	Local aEmpresa	:= {}
	Local nEmp		:= 0
	Local nI1		:= 0
	Local nI2		:= 0
	Local nX		:= 0
	Local nY		:= 0
	Local nZ		:= 0
	Local nI		:= 0
	
	cArquivo := cPathSrv + cArqDot

	//Verifica Arquivo
	If !File(cArquivo)
		MsgAlert("Arquivo : " + cArquivo + " Não Encontrado, Contate o suporte")
		Return Nil
	EndIf

	oObjReg:SetRegua1( Len( aUsuarios ) )

	For nX := 1 To Len( aUsuarios )
		
		oObjReg:IncRegua1( "Lendo Usuário: " + aUsuarios[nX][1][1] )
		
		aEmpresa	:= aUsuarios[nX][2][6]
		aModulos	:= aUsuarios[nX][3]

		If aUsuarios[nX][1][1] < cUserDe .Or. aUsuarios[nX][1][1] > cUserAte
			Loop
		EndIf
		
		If aUsuarios[nX][1][17] .And. nBloqueio == 2
			Loop
		EndIf
		
		Aadd( aImprime,	{;
						aUsuarios[nX][01][01],;		//[01] - ID do usuario
						aUsuarios[nX][01][12],;		//[02] - Departamento
						aUsuarios[nX][01][02],;		//[03] - Usuario Sistema
						aUsuarios[nX][01][04],;		//[04] - Nome Completo
						aUsuarios[nX][01][12],;		//[05] - Departamento
						aUsuarios[nX][02][03],;		//[06] - Diretorio de relatorios
						aUsuarios[nX][01][13],;		//[07] - Cargo
						aUsuarios[nX][01][20],;		//[08] - Ramal
						{},;							//[09] - Array com as empresas de acesso
						aUsuarios[nX][01][23][02],;	//[10] - Dias que pode retroceder
						aUsuarios[nX][01][23][03],;	//[11] - Dias que pode avancar
						aUsuarios[nX][01][15],;		//[12] - Quantidade de acessos
						{};								//[13] - Array com os modulos de acesso
						})
		
		//Array com acesso as empresas (Caso seja "@@@@" - Acesso Total)
		For nY := 1 To Len( aEmpresa )
			If aEmpresa[nY] == "@@@@"
				For nEmp := 1 To Len( aEmpSM0 )
					Aadd( aImprime[Len(aImprime)][09],	{;
														"S",;
														aEmpSM0[nEmp][01] + " / " + aEmpSM0[nEmp][02] + " - " + aEmpSM0[nEmp][04];
														})
				Next nEmp
			Else
				For nEmp := 1 To Len( aEmpSM0 )
					nPos := Ascan( aEmpresa, {|x| Alltrim(x) == Alltrim(aEmpSM0[nEmp][03]) })
					Aadd( aImprime[Len(aImprime)][09],	{;
														IIF( nPos > 0, "S", "N" ),;
														aEmpSM0[nEmp][01] + " / " + aEmpSM0[nEmp][02] + " - " + aEmpSM0[nEmp][04];
														})
					
				Next nEmp
			EndIf
		Next nY
		
		//Array com acesso aos modulos
		For nZ := 1 To Len( aModulos )
			Aadd( aImprime[Len(aImprime)][13],	{;
												IIF( SubStr(aModulos[nZ],3,1) == "X", "N", "S" ),;
												SubStr(aModulos[nZ],4);
												})
		Next nZ
		
	
	Next nX
	
	oObjReg:SetRegua2( Len( aUsuarios ) )
	
	If Len(aImprime) > 0

		//Apaga arquivo da Maquina caso exista
		If File( Alltrim( cPathLoc ) + cArqDot )
			If FErase( Alltrim( cPathLoc ) + cArqDot ) == -1
				MsgAlert("Erro ao apagar arquivo temporário: " + Alltrim( cPathLoc ) + cArqDot)
				Return Nil
			EndIf
		EndIf

		//Copia Arquivo .DOT temporario para Usuario
		If !CpyS2T(cArquivo, Alltrim( cPathLoc ), .T.)
			MsgAlert("Erro ao copiar arquivo do servidor para : " + Alltrim(cPathLoc))
			Return Nil
		Endif

		For nI := 1 To Len( aImprime )
			
			oObjReg:IncRegua2( "Imprimindo Usuário: " + aImprime[nI][01] )

			cArqNew	:= Alltrim( cPathLoc ) + aImprime[nI][01] + ".DOC"
			hWordC	:= OLE_CreateLink("TMSOLEWORD97")

			If !(Val(hWordC) == 0)
				MsgAlert("Erro ao Abrir o Microsoft Word","Contate Suporte!!!")
				Return Nil
			EndIf

			//Abre o Documento .DOT
			OLE_NewFile(hWordC, Alltrim( cPathLoc ) + cArqDot)

			OLE_SetDocumentVar(hWordC, "verprot"	, cVerProt					)

			OLE_SetDocumentVar(hWordC, "depto"		, aImprime[nI][02]			)
			OLE_SetDocumentVar(hWordC, "userprot"	, aImprime[nI][03]			)
			OLE_SetDocumentVar(hWordC, "nomecom"	, aImprime[nI][04]			)
			OLE_SetDocumentVar(hWordC, "dirrel"		, aImprime[nI][06]			)

			OLE_SetDocumentVar(hWordC, "planta"		, ""						)
			OLE_SetDocumentVar(hWordC, "cargo"		, aImprime[nI][07]			)
			OLE_SetDocumentVar(hWordC, "ramal"		, aImprime[nI][08]			)

			OLE_SetDocumentVar(hWordC, "retdata"	, aImprime[nI][10]			)
			OLE_SetDocumentVar(hWordC, "avdata"		, aImprime[nI][11]			)

			OLE_SetDocumentVar(hWordC, "qtdacess"	, aImprime[nI][12]			)

			//Atualiza Macro com os acessos de Empresas
			For nI1 := 1 To Len( aImprime[nI][09] )

				OLE_SetDocumentVar(hWordC,"prtemp_emp" 	+ AllTrim(Str(nI1))	, aImprime[nI][09][nI1][02]	)

				If aImprime[nI][09][nI1][01] == "S"
					OLE_SetDocumentVar(hWordC,"prtemp_sim" 	+ AllTrim(Str(nI1))	, "X"		)
					OLE_SetDocumentVar(hWordC,"prtemp_nao" 	+ AllTrim(Str(nI1))	, " "		)
				Else
					OLE_SetDocumentVar(hWordC,"prtemp_sim" 	+ AllTrim(Str(nI1))	, " "		)
					OLE_SetDocumentVar(hWordC,"prtemp_nao" 	+ AllTrim(Str(nI1))	, "X"		)
				EndIf
				
			Next nI1
			
			//Seta o Nro. de Linhas das Empresas
			OLE_SetDocumentVar(hWordC, 'prtemp_nroemp',Alltrim( Str( Len(aImprime[nI][09]) )) )
			
			//Atualiza Macro com os acessos de Modulos
			For nI2 := 1 To Len( aImprime[nI][13] )

				If aImprime[nI][13][nI2][01] == "S"
					OLE_SetDocumentVar(hWordC,"prtmod_sim" 	+ AllTrim(Str(nI2))	, "X"		)
					OLE_SetDocumentVar(hWordC,"prtmod_nao" 	+ AllTrim(Str(nI2))	, " "		)
				Else
					OLE_SetDocumentVar(hWordC,"prtmod_sim" 	+ AllTrim(Str(nI2))	, " "		)
					OLE_SetDocumentVar(hWordC,"prtmod_nao" 	+ AllTrim(Str(nI2))	, "X"		)
				EndIf

				OLE_SetDocumentVar(hWordC,"prtmod_mod" 	+ AllTrim(Str(nI2))	, aImprime[nI][13][nI2][02]	)

			Next nI2
			
			//Seta o Nro. de Linhas dos modulos
			OLE_SetDocumentVar(hWordC, 'prtmod_nromod',Alltrim( Str( Len(aImprime[nI][13]) )) )
			
			//Executa a Macro das Empresas
			OLE_ExecuteMacro(hWordC,"tabemp")
			
			//Executa a Macro das Empresas
			OLE_ExecuteMacro(hWordC,"tabmod")

			//Atualizando as variaveis do documento do Word
			OLE_UpdateFields(hWordC)      
		
			//Salva o Arquivo
			OLE_SaveAsFile(hWordC,cArqNew)
				
			//Fecha link / arquivo
			OLE_CloseFile(hWordC)
			OLE_CloseLink(hWordC)

		Next nI
		
		//Remove arquivo DOT da maquina do usuario
		If File( Alltrim( cPathLoc ) + cArqDot )
			If FErase( Alltrim( cPathLoc ) + cArqDot ) == -1
				MsgAlert("Erro ao apagar arquivo temporário: " + Alltrim( cPathLoc ) + cArqDot)
				Return Nil
			EndIf
		EndIf
		
		MsgInfo("Processo finalizado com sucesso")

	Else
		MsgInfo("Não existem dados para serem impressos, verifique os parametros")
	EndIf

Return Nil

/*==========================================================================
 Funcao...........:	GetFil
 Descricao........:	Retorna Filiais do sistema
 Autor............:	Amedeo D. Paoli Filho
 Data.............:	05/05/2014
 Parametros.......:	Nil
 Retorno..........:	Nil
==========================================================================*/
Static Function GetFil()
	Local aRetorno	:= {}
	Local aAreaSM0	:= SM0->(GetArea())
	
	DbSelectarea("SM0")
	SM0->(DbGoTop())
	While !SM0->(Eof())
		Aadd( aRetorno,	{;
						Alltrim( SM0->M0_CODFIL ),;
						Alltrim( SM0->M0_FILIAL ),;
						SM0->M0_CODIGO + SM0->M0_CODFIL,;
						Alltrim( SM0->M0_FILIAL ) + " - " + SM0->M0_NOME;
						})
		SM0->(DbSkip())
	End
	
	RestArea(aAreaSM0)
	
Return aRetorno
