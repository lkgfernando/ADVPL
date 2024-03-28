#include "rwmake.ch"
#include "topconn.ch"
#include "apvt100.ch"
#include "totvs.ch"
#include "Tbiconn.ch"

#DEFINE ENTER CHAR(13) + CHAR(10)

/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ BATCOL04 ºAutor  ³ Thiago Mello       º Data ³  17/03/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Programa para apontamentos de producao via microterminal   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PCP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function BATCOL04()
	********************
	PRIVATE cOpcx, cSelo, lVoltar, lAbrir, cOP, cProd, cCC, aOP,nQtdOp2
	PRIVATE cOper, cCTrab, cTpAp, cAcao, nQuant, cErro, nQtdOP,lInspecao,LEHPARADA,lRetrabInic,cHoraApt,nQtdHrs,lRetrabCttI
	PRIVATE cQuery, cGrupo, lTpAp, cIPClient, lRetrabalho,lErroAptfimR,lErroAptIniR,lFimHExtra,lUltApEhfim,lFimproduc
	PRIVATE nRecUltAp := 0 //Recno Ultimo Apontamento
	PRIVATE nRecUltOr := 0 //Recno do Apontamento Origem
	PRIVATE cTplancam := ""
	PRIVATE cOpEmAbert := ""
	Private lExistOper := .F.
	Private TpHora	   := ""
	Private cXFilial

	Public CFILANT := "21"

//Monto ambiente
////////////////
	MsApp():New("SIGAACD",.T.)
	oApp:cInternet := NIL
	oApp:lIsBlind := .T.
	oApp:CreateEnv()

//Chammo funcoes de ambiente
////////////////////////////
	TerProtocolo("VT100")
	SetsDefault()

//Teste modelo terminal
//VTSetSize(2,16)
//@ 0,0 VTSay TerModelo()
//Sleep(5000)

	If TerModelo()=="MT44" .OR. TerModelo()=="MT16"
		VTSetSize(2,16)

		//Tela de saudacao
		//////////////////
		VTClear()
		@ 0,0 VTSay "MAQUIGERAL"
		@ 1,0 VTSay "MICROTERMINAIS"
		Sleep(3000)
	Else
		VTSetSize(4,20)

		//Tela de saudacao
		//////////////////
		VTClear()
		@ 0,2 VTSay "MAQUIGERAL"
		@ 1,3 VTSay "MICROTERMINAIS"
		Sleep(3000)

//	u_BATCOL03()
		KillApp()
		Return
	EndIf

//cIpClient := GetClientIp() //nao funciona!!

//Tela de saudacao
//////////////////
	VTClear()()
	@ 0,0 VTSay "MAQUIGERAL"
	@ 1,0 VTSay "BATCOL04 - V 1.0"
	Sleep(1000)

//Rotina principal
//////////////////
	While !KillApp()
		//Verifica Filial
		// Digitar a Filial 21 ou 22 | Cesar Padovani
		// Solicita a Filial
		While !KillApp()
			VTClearBuffer()
			cXFilial := Space(02)
			VTClear()
			@ 0,0 VTSay "FILIAL"
			@ 1,0 VTSay ">" VTGet cXFilial picture "@!"
			VTRead()
			IF Empty(cXFilial)
				Exit
			EndIf
			If Alltrim(cXFilial)=="21" .or. Alltrim(cXFilial)=="22"
				@ 0,0 VTSay "MAQUIGERAL"
				@ 1,0 VTSay "FILIAL "+cXFilial
				Sleep(1000)
				//Abro tabelas necessarias
				//////////////////////////
				@ 1,0 VTSay "Abrindo Tabelas "
				RpcClearEnv()
				RpcSetType(3)
				RPCSetEnv("01",cXFilial,"","","PCP","",{"SB1","SC2","SD3","ZA1","ZA2","ZA3","SHB"}, , , , )
				CFILANT := cXFilial
				@ 1,0 VTSay "Tabelas OK!!!   "
				Sleep(1000)
			Else
				Loop
			Endif
			Exit
		Enddo

		//Zero variaveis
		////////////////
		lAbrir  := .F.
		lVoltar := .F.
		VTClearBuffer()

		//Verifico Operador X Centro de Trabalho
		///////////////////
		While !KillApp()

			//Solicito Cod OPerador
			////////////////////
			While !KillApp()
				VTClearBuffer()
				cOper := Space(08)
				VTClear()
				@ 0,0 VTSay "CODIGO OPERADOR"
				@ 1,0 VTSay ">" VTGet cOper picture "@99999999"
				VTRead()
				IF Empty(cOper)
					Exit
				EndIf
				If !fVerOper()
					Exit
				Endif
				Exit
			Enddo

			IF Empty(cOper)
				Loop
			EndIf

			//Solicito Centro de Trabalho
			////////////////////
			While !KillApp()
				VTClearBuffer()
				cCTrab := Space(07)
				VTClear()
				@ 0,0 VTSay "CENTRO TRABALHO"
				@ 1,0 VTSay ">" VTGet cCTrab picture "@999999"
				VTRead()
				IF Empty(cCTrab)
					Exit
				EndIf
				cCTrab := Alltrim(cCTrab)
				If !fVerCTrab()
					Loop
				Endif
				Exit
			Enddo

			IF Empty(cCTrab)
				Loop
			EndIf

			If !fVerCTrabOper()
				Loop
			Endif
			Exit
		EndDo

		//No acabamento varias OP´s sao executadas
		//ao mesmo tempo pelo mesmo operador, neste caso,
		//o total de mao-de-obra deve ser dividido entre as OP´s

		nQtdOP := 0
	/* Comentado por Jackson SAntos - conforme solicitação da Sandra, pois na filial 21 - Embu não deverá ser tratado dessa forma.
	If cCTrab$"000001,000005,000008"
		If fConfirma("Divide MO por OP")
			VTClearBuffer()
			VTClear()
			@ 0,0 VTSay "QUANTAS O.P.?"
			@ 1,0 VTSay ">" VTGet nQtdOP pict "99"
			VTRead()
		EndIf
		If nQtdOP <= 1
			nQtdOP := 0
		EndIf
	EndIf
	*/
		If cCTrab$"000001,000003,000005"
			VTClearBuffer()
			VTClear()
			If fConfirma("Divide MO por OP")
				VTClearBuffer()
				VTClear()
				@ 0,0 VTSay "QUANTAS O.P.?"
				@ 1,0 VTSay ">" VTGet nQtdOP picture "@99"
				VTRead()
			EndIf
			If nQtdOP <= 1
				nQtdOP := 0
			EndIf
		EndIf

		If nQtdOP==0
			//Solicito Cod OP
			////////////////////
			While !KillApp()
				VTClearBuffer()
				cOP := Space(11)
				VTClear()
				@ 0,0 VTSay "CODIGO O.P."
				@ 1,0 VTSay ">" VTGet cOP picture "@99999999999"
				VTRead()
				//conout(cOP)
				IF Empty(cOP)
					Exit
				EndIf
				If !fVerOP()
					Loop
				Endif
				Exit
			Enddo
			IF Empty(cOP)
				Loop
			EndIf
		Else
			cGrupo := ""
			aOP := {}
			For i:=1 to nQtdOP
				//Solicito Cod OP
				////////////////////
				While !KillApp()
					VTClearBuffer()
					cOP := Space(12)
					VTClear()
					@ 0,0 VTSay "INFORME O.P. "+Transform(i,"@E 99")
					@ 1,0 VTSay ">" VTGet cOP picture "@E 999999999999"
					VTRead()
					//conout(cOP)
					IF Empty(Alltrim(cOP))
						Exit
					EndIf
					If !fVerOP()
						Loop
					Endif
					Aadd(aOP,{Alltrim(cOP)})
					Exit
				EndDo
			Next i
		EndIf

		//Solicito Tipo Apontamento
		////////////////////
		While !KillApp()
			VTClearBuffer()
			cTpAp := Space(2)
			VTClear()
			@ 0,0 VTSay "TIPO APONTAMENTO"
			@ 1,0 VTSay ">" VTGet cTpAp picture "@!"
			VTRead()
			IF Empty(cTpAp)
				Exit
			EndIf
			lTpAp := .T.
			If nQtdOP==0
				cOpEmAbert := ""
				If !fVerTpAp()
					lTpAp := .F.
					If !Empty(cOpEmAbert)
						Exit
					EndIf
				Endif
			Else
				For i:=1 to nQtdOP
					cOp := ALLTRIM(aOP[i,1])
					If !fVerTpAp()
						lTpAp := .F.
					Endif
				Next i
			EndIf
			If !lTpAp
				Loop
			EndIf
			Exit
		Enddo

		If Empty(cTpAp)
			Loop
		EndIf

		//Efetivar Apontamento
		//////////////////////
		//If fConfirma("Confirma Apont.?")
		If nQtdOP==0
			//Verifica se existe a operação
			cProdApt := SC2->C2_PRODUTO

			lExistOper := VldOperacao() .And. !Empty(Alltrim(SC2->C2_ROTEIRO))

			If Empty(Alltrim(cOpEmAbert))  //.And. lExistOper
				VTClear()
				@ 0,0 VTSay "EFETIVANDO"
				@ 1,0 VTSay "APONTAMENTO..."
				Sleep(1000)
				If fAptProducao()
					VTClear()
					@ 0,3 VTSay "**AVISO**"
					@ 1,0 VTSay "APONT.EFETIVADO!"
					Sleep(3000)
				Else
					VTClear()
					@ 0,4 VTSay "**ERRO**"
					@ 1,0 VTSay "ERRO APONTAMENTO"
					Sleep(3000)
				Endif
			/*Else
				If !lExistOper
				    VTClear()
					@ 0,4 VTSay "**ERRO**"
					@ 1,0 VTSay "ERRO NUMERO 019"
					Sleep(3000)					
				EndIf
				*/
			EndIf
			Loop
		Else
			VTClear()
			@ 0,0 VTSay "EFETIVANDO"
			@ 1,0 VTSay "APONTAMENTOS.."
			Sleep(1000)
			For z:=1 to Len(aOP)
				cOp := Alltrim(aOP[z,1])
//				conout("valor de aop e cop")
//				conout(aop[z,1])
//				conout(cOP)              
				cProdApt := Posicione("SC2",1,xFilial("SC2") + cOp,"C2_PRODUTO")
				cRoteiro := Posicione("SC2",1,xFilial("SC2") + cOp,"C2_ROTEIRO")
				lExistOper := .F. //VldOperacao() .And. !Empty(Alltrim(cRoteiro))
				If fAptProducao()
					VTClear()
					@ 0,3 VTSay "**AVISO**"
					@ 1,0 VTSay "EFETIVADA OP "+Transform(z,"@E 99")
					Sleep(3000)
				Else
					VTClear()
					@ 0,4 VTSay "**ERRO**"
					@ 1,0 VTSay "ERRO OP "+Transform(z,"@E 99")
					Sleep(3000)
				Endif
			Next z
			Loop
		EndIf
		//Endif

	Enddo

Return


Static Function fVerOper()
	********************************
	Local lRet := .T.

//Verifico se Operador Existe e
///////////////////////////
	ZA3->(dbSetOrder(1))//ZA3_FILIAL+ZA3_COD+ZA3_CTRAB
	If ZA3->(!dbSeek(xFilial("ZA3")+cOper))
		lRet  := .F.
		VTClear()
		@ 0,4 VTSay "**ERRO**"
		@ 1,0 VTSay "CODIGO INVALIDO!"
		Sleep(3000)
	ElseIf Alltrim(ZA3->ZA3_MSBLQL)=="1"
		lRet  := .F.
		VTClear()
		@ 0,4 VTSay "**ERRO**"
		@ 1,0 VTSay "OPERADOR BLOQUEADO!"
		Sleep(3000)
		VTClear()
	EndIf

Return(lRet)


Static Function fVerCTrab()
	********************************
	Local lRet := .T.
	cProd := Space(15)
	cCC   := Space(15)

//Verifico se Centro Trabalho Existe
///////////////////////////
	SHB->(dbSetOrder(1))//HB_FILIAL+HB_COD
	If SHB->(dbSeek(xFilial("SHB")+cCTrab)) .and. !Empty(cCTrab)
		cProd  := "MOD"+Alltrim(SHB->HB_CC)
		cCC    := Alltrim(SHB->HB_CC)
	Else
		lRet  := .F.
		VTClear()
		@ 0,4 VTSay "**ERRO**"
		@ 1,0 VTSay "CODIGO INVALIDO!"
		Sleep(3000)
	EndIf

Return(lRet)


Static Function fVerCTrabOper()
	********************************
	Local lRet := .T.

//Verifico se Operador Existe e
//é do centro de trabalho do coletor
///////////////////////////
	ZA3->(dbSetOrder(1))//ZA3_FILIAL+ZA3_COD+ZA3_CTRAB
	If ZA3->(!dbSeek(xFilial("ZA3")+cOper+cCTrab))
		lRet  := .F.
		VTClear()
		@ 0,4 VTSay "**ERRO**"
		@ 1,0 VTSay "ERRO NUMERO 004"
		Sleep(3000)
	EndIf

Return(lRet)


Static Function fVerOP()
	********************************
	Local lRet := .T.
	Local lEncerrada := .F.
	Local cUltAcaoOp := ""
//Verifico se OP Existe e Está aberta
///////////////////////////
	nQtdOp2 := 0
	SC2->(dbSetOrder(1))
	SC2->(DbGoTop())
	If SC2->(dbSeek(cXFilial+Alltrim(cOP)))
		if SC2->(C2_NUM + C2_ITEM + C2_SEQUEN) == Alltrim(cOP)
			nQtdOp2 := SC2->C2_QUANT
			//If !Empty(SC2->C2_DATRF) //Op Encerrada
			If SC2->C2_DATRF<>CTOD("  /  /  ") //Op Encerrada
				lRet  := .F.
				lEncerrada := .T.
			Else
				lRet  := .T.
				lEncerrada := .F.
			EndIF
		Else
			lRet  := .F.
		Endif
	Else
		lRet  := .F.
	Endif
	If !lRet
		VTClear()
		@ 0,4 VTSay "**ERRO**"
		If lEncerrada
			@ 1,0 VTSay "ERRO NUMERO 017"
		Else
			@ 1,0 VTSay "OP N/C F:"+cXFilial+"-OP:"+cOP
		Endif
		Sleep(3000)
	EndIf

Return(lRet)


Static Function fVerTpAp()
	********************************
	Local lRet := .T.

//Verifico se Tipo Apontamento existe e é Válido
///////////////////////////
	ZA2->(dbSetOrder(1))//ZA2_FILIAL+ZA2_TIPO+ZA2_ACAO
	If ZA2->(dbSeek(xFilial("ZA2")+cTpAp))
		cAcao := ZA2->ZA2_ACAO
		//Valida Apontamento
		lRet  := fValidaTpAp()
	Else
		lRet  := .F.
		cErro := "003"
	EndIf

	If !lRet
		VTClear()
		@ 0,4 VTSay "**ERRO**"
		@ 1,0 VTSay "ERRO NUMERO "+cErro

		Sleep(3000)
	EndIf

//Valida se Não Existe OP já em andamento
//Barramento é o único centro de trabalhoa que pode abrir 
//mais ce uma op.
	If cAcao == "I" .And. !Alltrim(cCTrab) $ "000001/000003/000005/000010" .And. lRet
		conout("Validando se já existe op em aberto")
		cqryOp := " SELECT * FROM "  + RetSqlName("ZA1") + " ZA1 "
		cqryOp += " JOIN " + RetSqlName("SC2") + " SC2 ON SC2.D_E_L_E_T_ <> '*' AND SC2.C2_FILIAL = ZA1.ZA1_FILIAL AND SC2.C2_NUM + SC2.C2_ITEM + SC2.C2_SEQUEN = ZA1.ZA1_OP AND SC2.C2_DATRF = '' "
		cqryOp += " WHERE ZA1.D_E_L_E_T_ <> '*' AND ZA1_FILIAL = '" + xFilial("ZA1") + "' AND ZA1_DATA >= '20170101' "
		//cqryOp += "  AND ZA1_DATA = '" + DTOS(DdataBase) + "' "
		cqryOp += "  AND ZA1_MOV <> 'S' AND ZA1.ZA1_ORIGEM = 0 "
		//cqryOp += "  AND ZA1_CTRAB = '" + cCTrab + "' "
		cqryOp += "  AND ZA1_OPER = '" + cOper + "' "
		//cqryOp += "  AND ZA1_OP <> '" + cOP + "' "
		cqryOp += "   ORDER BY ZA1.R_E_C_N_O_ "


		If Select("TRBOP") > 0
			TRBOP->(DbCloseArea())
		EndIf
		TCQUERY cQryOP NEW ALIAS "TRBOP"
		If TRBOP->(!EoF())
			While TRBOP->(!EoF())
				cUltAcaoOp := TRBOP->ZA1_ACAO
				cOpEmAbert := TRBOP->ZA1_OP
				TRBOP->( DbSkip())
			EndDo
			Conout("Ordem de Producao em aberto - Ultima Acao : " + cUltAcaoOp + " Ctrab " + cCTrab + "cOper "  + cOper)
			TRBOP->(DbCloseArea())
			If !Alltrim(cUltAcaoOp) $  "F/P" //Se não estiver parada ou finalizada

				lRet :=.F.
				VTClear()
				@ 0,4 VTSay "**ERRO**"
				@ 1,0 VTSay "ERRO NUMERO 020"
				Sleep(3000)
			Else
				cOpEmAbert := ""
			EndIf
		EndIf
	Else
		cOpEmAbert := ""
	EndIf

Return(lRet)


Static Function fValidaTpAp()
	********************************
	Local lTpAp     := .T.
	Local cUltAp    := "00"
	Local cUltCTrab := "000000"
	Local dUltData  := StoD("  /  /  ")
	Local cUltAcao  := "0"

	lRetrabalho := (Alltrim(cTpAp) == "11" .Or. cTpAp == "91")
	lInspecao 	:= (Alltrim(cTpAp) == "07" .Or. cTpAp == "08")
	lFimHExtra	:= (Alltrim(cTpAp) == "03" ) //.And. ( dDataBase > dUltData .Or. Time() > "16:30:00"))
	lFimproduc  := (Alltrim(cTpAp) == "99" ) //.And. ( dDataBase > dUltData .Or. Time() > "17:30:00"))
	lEhParada	:= ((Alltrim(cTpAp) == "02" .Or. Alltrim(cTpAp) == "04" .Or. Alltrim(cTpAp) == "05" .Or. Alltrim(cTpAp) == "06" ) .And. ( dDataBase > dUltData .Or. Time() > "17:30:00"))
	lRetrabInic := .F.
	lRetrabCttI := .F.

	ZA1->(DbSetOrder(1))//ZA1_FILIAL+ZA1_OP+ZA1_DATA+ZA1_HORA
	ZA1->(DbGoTop())
	ZA1->(DBSeek(xFilial("ZA1")+cOP))
	While ZA1->(!EOF()) .and. ZA1->ZA1_FILIAL==xFilial("ZA1") .and. Alltrim(ZA1->ZA1_OP)==Alltrim(cOP)
		If ZA1->ZA1_OPER == cOper .and. ZA1->ZA1_CTRAB == cCTrab //.and. ZA1->ZA1_MOV<>"S"
			cUltAp    := ZA1->ZA1_TIPO
			cUltCTrab := ZA1->ZA1_CTRAB
			dUltData  := ZA1->ZA1_DATA
			cUltAcao  := ZA1->ZA1_ACAO
			nRecUltAp := ZA1->(Recno())
			nRecUltOr := ZA1->ZA1_ORIGEM
			cTplancam := ZA1->ZA1_TPLANC
			cHoraApt  := ZA1->ZA1_HORA
			If ZA1->ZA1_TIPO == "11"
				lRetrabInic := .T.
			EndIf
			If ZA1->ZA1_TIPO == "91"
				lRetrabInic := .F.
			EndIf
			If ZA1->ZA1_TIPO == "10" //Retrabalho Centro de Trabalho
				lRetrabCttI  := .T.
			Endif
		EndIf
		ZA1->(DbSkip())
	EndDo
	IIf (cUltAcao =="P",lUltApEhfim := .T.,lUltApEhfim := .F.)
//conout("cUltApont" + cUltAp  + " OP: " + cOP +  " cTrab: " + cUltCTrab + "cUltAcao: " + cUltAcao + " Filial: " + xFilial("ZA1"))
	If cUltAp<>"00"
		lErroAptIniR := (!Alltrim(cUltAp) $ "99/91"  .And. Alltrim(cTpAp) == "11") //Só iniciar retrabalho de opós finalizadas.
		lErroAptfimR := (lRetrabInic .And. cAcao == "F" .And. Alltrim(cTpAp) <> "91")

		Do Case
		Case cUltAcao=="I" .and. cAcao=="I" //Op Já foi iniciada pelo Operador
			lTpAp := .F.
			cErro := "005"
		Case cUltAcao<>"F" .and. cAcao=="I" .and. cCTrab<>cUltCTrab  //Não pode iniciar OP neste centro de trabalho
			lTpAp := .F.                                            //antes de finalizar a mesma OP no centro de trabalho anterior
			cErro := "006"
		Case cUltAcao=="P" .and. cAcao<>"I" .And. !lFimproduc .And. !lFimHExtra .And. lUltApEhfim .And. !lEhParada //Op parada só pode ser iniciada.
			lTpAp := .F.
			cErro := "007"
		Case cUltAcao<>"I" .and. cAcao=="F"  //Só pode finalizar se tiver sido iniciada.
			lTpAp := .F.
			cErro := "008"
		Case cUltAcao=="F" .and. cCTrab==cUltCTrab .And. !lRetrabalho .And. !lRetrabInic .And. !lInspecao  //OP já foi finalizada neste Centro de Trabalho, não pode ter mais apontamentos. a não ser que seja retrabalho.
			//Conout("Passou pela mensagem de para não apontar 009")
			lTpAp := .F.
			cErro := "009"
		Case cUltAcao=="I" .and. dUltData<>MsDate() //OP não encerrada anteriormente. Problema nos apontamentos do último dia desta OP.
			lTpAp := .F.
			cErro := "010"
		Case cAcao<>"I" .and. dUltData<>MsDate() //Só pode parar ou finalizar no mesmo dia do inicio
			lTpAp := .F.
			cErro := "011"
		Case cAcao == "F" .And. lRetrabalho .And.  (!lRetrabInic .Or. lErroAptFimR )
			lTpAp := .F.
			cErro := "016"
		/*
		Case cAcao == "I" .And. cUltAcao == "P" .And. cUltAp == "02" //Se está parada por hora de almoço.
			lTpAp := .F.
		    cErro := "017"
		*/
		Case cAcao == "I" .And. lRetrabalho .And. lErroAptIniR
			lTpAp := .F.
			cErro := "018"
		/* Case cAcao <> "I" .And. lRetrabCttI .And. (!lRetrabInic .Or. lErroAptFimR )  .And. Alltrim(cTpAp) <> "10"
		 	lTpAp := .F.
		    cErro := "021"	//Op com retrabalho iniciado, só pode ser apontado fim de retrabalho.
		    */	    
		EndCase
	ElseIf cAcao<>"I" //É o Primeiro apontamento
		lTpAp := .F.
		cErro := "012"
	EndIF

Return(lTpAp)


Static Function fConfirma(xTexto)
	********************************
	LOCAL lRetu := .F., cTexto
	cTexto := Alltrim(xTexto)
	cTexto := cTexto+Space(16-Len(cTexto))
	cOpcx  := Space(1)
	VTClearBuffer()
	VTClear()
	@ 0,0 VTSay cTexto
	@ 1,0 VTSay "1=Sim/2=Nao>" VTGet cOpcx picture "9"
	VTRead()
	If cOpcx == "1" //Sim
		lRetu := .T.
	Endif
Return lRetu


Static Function fAptProducao()
	******************************
	Local lRet   := .T.
	Local aQuant := {}
	Local cTempo := ""
	Local aZA1REC := {}
	Local aVetor := {}
	Local dData

	Private cXDocD3 := ""


	TpHora := SuperGetMV("MV_TPHR",.f.,"C")

	lMsErroAuto := .F.

	If nQtdOP > 0 .and. cAcao=="I" .and. Empty(cGrupo)
		cQuery := "SELECT MAX(ZA1_GRUPO) AS GRUPO FROM "+RetSqlName("ZA1")
		If select("GRP") > 0
			dbCloseArea("GRP")
		EndIf

		TcQuery cQuery NEW Alias "GRP"

		DbSelectArea("GRP")

		cGrupo := Soma1(GRP->GRUPO,6)

		GRP->(DbCloseArea())
	ElseIf cAcao<>"I"
		//Caso seja parada de hora extra - Deleto o apontamento Existente de parada fim de Expediente.
	/*
	If (lFimHExtra .Or. lFimproduc .Or. lEhParada) .And. nRecUltAp > 0 .And. lUltApEhfim	.And. cTplancam == "A"
	    Conout("Deletando último apontamento")
	    ZA1->(DbGoTo(nRecUltAp))
	    Reclock("ZA1",.F.)
	    	ZA1->(DbDelete())
	    ZA1->(MSunlock())	
		
		//Apagar a Origem e o Movimeto do apontamento para refazer
		ZA1->(DbGoTo(nRecUltOr)) 
		Reclock("ZA1",.F.)
	        ZA1->ZA1_MOV := ""
	        ZA1->ZA1_ORIGEM := 0 
		ZA1->(MSunlock())			
	EndIf
	*/
		cQuery := " SELECT ZA1_GRUPO AS GRUPO, R_E_C_N_O_ AS RECZA1 "
		cQuery += " FROM "+RetSqlName("ZA1")
		cQuery += " WHERE ZA1_FILIAL = '"+xFilial("ZA1")+"' "
		cQuery += " AND ZA1_OP = '"+cOP+"' "
		cQuery += " AND ZA1_ACAO = 'I' "
		cQuery += " AND ZA1_OPER = '"+cOper+"' "
		cQuery += " AND ZA1_CTRAB =	'"+cCTrab+"' "
		cQuery += " AND ZA1_DATA = '"+Dtos(MsDate())+"' "
		cQuery += " AND ZA1_MOV	<> 'S' "
		cQuery += " AND D_E_L_E_T_='' "

		If select("GRP") > 0
			dbCloseArea("GRP")
		EndIf

		TcQuery cQuery NEW Alias "GRP"

		DbSelectArea("GRP")
		GRP->(DbGoTop())

		If GRP->(EOF())
			cGrupo := ""
			lRet   := .F.
			cErro  := "016" //Nao encontrada OP iniciada.
		Else
			If nQtdOP > 0
				cGrupo := GRP->GRUPO
			EndIf
			Aadd(aZA1REC,{GRP->RECZA1})
		EndIf
		GRP->(DbCloseArea())
	EndIF

	If lRet
		CONOUT("Gravando Apontamento")
		Begin Transaction

			RecLock("ZA1",.T.)
			REPLACE ZA1->ZA1_FILIAL WITH xFilial("ZA1")
			REPLACE ZA1->ZA1_DATA   WITH MsDate()
			REPLACE ZA1->ZA1_HORA   WITH Time()
			REPLACE ZA1->ZA1_OPER   WITH cOper
			REPLACE ZA1->ZA1_OP     WITH cOp
			REPLACE ZA1->ZA1_MOD    WITH cProd
			REPLACE ZA1->ZA1_CTRAB  WITH cCTrab
			REPLACE ZA1->ZA1_CC     WITH cCC
			REPLACE ZA1->ZA1_TIPO   WITH cTpAp
			REPLACE ZA1->ZA1_ACAO   WITH cAcao
			REPLACE ZA1->ZA1_GRUPO  WITH cGrupo
			ZA1->(MsUnlock())
			Aadd(aZA1REC,{ZA1->(Recno())})

			If cAcao<>"I" //faço o movimento interno da mao-de-obra
				nQuant := 0
				nQtdHrs := 0

				ZA1->(DbSetOrder(1))//ZA1_FILIAL+ZA1_OP+ZA1_DATA+ZA1_HORA
				ZA1->(MsSeek(xFilial("ZA1")+cOP))
				While ZA1->(!EOF()) .and. ZA1->ZA1_FILIAL==xFilial("ZA1") .and. Alltrim(ZA1->ZA1_OP)==Alltrim(cOP)
					If ZA1->ZA1_ACAO == "I" .and. ZA1->ZA1_CTRAB == cCTrab .and. ZA1->ZA1_OPER == cOper .and. ZA1->ZA1_MOV <> "S"
						Aadd(aQuant,{ZA1->ZA1_DATA,ZA1->ZA1_HORA,""})
					ElseIf ZA1->ZA1_CTRAB == cCTrab .and. ZA1->ZA1_OPER == cOper .and. ZA1->ZA1_MOV <> "S"
						IF Len(aQuant) > 0
							If ZA1->ZA1_DATA==aQuant[Len(aQuant),1]
								aQuant[Len(aQuant),3] := ZA1->ZA1_HORA
							Else
								lRet  := .F.
								cErro := "015"
								//Conout("Erro apontamento - " + cErro)
								Exit
							EndIf
						EndIf
					EndIf
					ZA1->(DbSkip())
				EndDo
				//conout("Verifica o tamanho do aQuant : " + STRZERO(Len(aQuant),2))
				If lRet .and. Len(aQuant)>0
					//For i:=1 to Len(aQuant)
					//Calcula diferença entre horas apontadas.
					//ElapTime ( < cHoraInicial>, < cHoraFinal> ) --> cRet Ex 13:12:35
					//			conout("Valor de aQuant[i,1]")
					//			conout(aQuant[i,1])
					//			conout("Valor de aQuant[i,2]")
					//			conout(aQuant[i,2])
					//			conout("Valor de aQuant[i,3]")
					//			conout(aQuant[i,3])
					//Conout("Tempos da OP " + aQuant[i,2] + aQuant[i,3] + cCTrab + ZA1->ZA1_OPER  + cOP )
					cTempo := ElapTime(aQuant[1,2],aQuant[Len(aQuant),3])
					//Conout("Tempos da OP " + ElapTime (aQuant[i,2],aQuant[i,3]) )

					nQuant += Val(SubStr(cTempo,1,2))*60 //transforma horas em minutos
					nQuant += Val(SubStr(cTempo,4,2))    //soma os minutos
					If TpHora == "C"
						nQtdHrs +=  Val(SubStr(cTempo,1,2)) +  Val(SubStr(cTempo,4,2))  / 60 //Hora Centesimal
					Else
						nQtdHrs +=  Val(SubStr(cTempo,1,2)) +  Val(SubStr(cTempo,4,2))  / 100 //Hora Centesimal
					EndIf
					//nQuant += VAL("0." + Alltrim(STR(ROUND((Val(SubStr(cTempo,7,2)) / 60) * 100,0))))   //soma os minutos

					//Next i

					If nQtdOP > 0 //divide os minutos entre as op´s do grupo
						nQuant := Round(nQuant/nQtdOP,0)
						nQtdHrs := Round(nQtdHrs/nQtdOP,2)
					EndIf

					ConOut("Passou1")
					If nQuant>0
						ConOut("Passou2")
						//If !lExistOper .OR. (cCTrab$"000003,000005")

						ConOut("Passou3")
						lRet := fMovInterno() //não será mais apontado pelo simples, agora pelo modeloII que já lança as Horas da MOD.
						//Else
						//ConOut("Passou4")
						//lRet := .T.
						//Endif
					Else
						ConOut("Passou5")
						lRet := .F.
						cErro := "013"
					EndIf
					If lRet
						For i:=1 to Len(aZA1REC)
							ZA1->(DbGoTo(aZA1REC[i,1]))
							RecLock("ZA1",.F.)
							REPLACE ZA1->ZA1_MOV    WITH "S"
							If i==2
								REPLACE ZA1->ZA1_TEMPO  WITH nQuant
								REPLACE ZA1->ZA1_TEMPHR WITH nQtdHrs
								REPLACE ZA1->ZA1_ORIGEM WITH aZA1REC[1,1]
							ElseIf i==1
								REPLACE ZA1->ZA1_ORIGEM WITH aZA1REC[2,1]
							EndIf

							REPLACE ZA1->ZA1_NDOCD3 WITH cXDocD3

							ZA1->(MsUnlock())
						Next i

						//If lExistOper
						//	lRet := RMATA681(aZA1REC)
						//EndIf
					Else
						Conout("Erro apontamento - " + "lRet após passar pelo erro : " + cErro)
						lRet := .F.
					EndIF
				Else
					Conout("Erro apontamento - " + "Len(aQuant) > 0 ")
					lRet := .F.
				EndIf
			EndIf
			If !lRet
				//DbCommitAll()
				DisarmTransaction()
				Conout("Transacao desfeito devido a erro no apontamento")
			Else
				DbCommitAll()
				lRet := .T.
			EndIf
		End Transaction
	EndIf

Return(lRet)


Static Function fMovInterno()
	******************************
	Local lRet  := .T.
	Local aCab  := {}
	Local aItem := {}
	Local cDoc  := ""
	Local cQuery := ""

	SB1->(DbSetOrder(1))
	SB1->(MsSeek(xFilial("SB1")+cProd))

//Monto variavel para efetuar apontamento de producao
//////////////////////////////////////////////////////
/*
cDoc := NextNumero("SD3",2,"D3_DOC",.T.)
Conout("Documento: "+cDoc)
// Verifica se o numero de documento ja foi utilizado
dbSelectArea("SD3")
nOrder:=IndexOrd()
dbSetOrder(2)
dbSeek(xFilial("SD3")+cDoc)
*/
	cQuery := "SELECT MAX(D3_DOC) D3_DOC FROM "+RetSQLName("SD3")+" WHERE D_E_L_E_T_='' AND D3_FILIAL='"+cXFilial+"' AND D3_DOC<>'INVENT' AND LEFT(D3_DOC,2)<>'SK' "
	If Select("TRBSD3")<>0
		TRBSD3->(DbCloseArea())
	EndIf
	TCQUERY cQuery NEW ALIAS "TRBSD3"
	DbSelectArea("TRBSD3")
	DbGoTop()
	If TRBSD3->(Eof())
		cDoc := StrZero(1,TamSx3("D3_DOC")[1])
	Else
		cDoc := Soma1(TRBSD3->D3_DOC)
	EndIf

	cMay := "SD3"+Alltrim(xFilial("SD3"))+cDoc
	lFirstNum :=.T.
/*
While D3_FILIAL+D3_DOC==xFilial("SD3")+cDoc.Or.!MayIUseCode(cMay)
	If D3_ESTORNO # "S"
		If lFirstNum
			cDoc := NextNumero("SD3",2,"D3_DOC",.T.)
			cDoc := A261RetINV(cDoc)
			lFirstNum :=.F.
		Else
			cDoc := Soma1(cDoc)
		EndIf
		lChangeDoc := .T.
		cMay := "SD3"+Alltrim(xFilial("SD3"))+cDoc
	EndIf
	dbSkip()
EndDo
dbSetOrder(nOrder)
*/
	If !lFirstNum
		Conout("Novo Documento: "+cDoc)
	EndIf

	cXDocD3 := cDoc

	aCab := {{"D3_DOC"    , cDoc     , Nil },;
		{"D3_TM"     , "510"    , Nil },;
		{"D3_CC"     , cCC      , Nil },;
		{"D3_EMISSAO", MsDate() , Nil }}

	Aadd(aItem,{{"D3_OP"      ,cOp            ,Nil},;  //Ordem de Producao
	{"D3_COD"     ,SB1->B1_COD    ,Nil},;  //Codigo do produto
	{"D3_QUANT"   ,/*nQuant*/ nQtdHrs,Nil},;  //Quantidade
	{"D3_LOCAL"   ,"01"           ,Nil},;  //Almoxarifado
	{"D3_UM"      ,SB1->B1_UM     ,Nil}})  //Unidade de medida

//Efetivo o Movimento Interno
/////////////////////////////
//Begin Transaction
	lMsErroAuto := .F.

	MSExecAuto({|x,y|MATA241(x,y)},aCab,aItem,3) //Inclusao

	If lMsErroAuto
		//conout(mostraerro())
		Conout("Erro apontamento - " + 	"ERRO EXECAUTO MATA241")
		MostraErro("\erros\","Batcol04_Erro-"+cOP+"-"+cDoc+".txt")
		DisarmTransaction()
		If  MsDate() >= CtoD("01/04/2018")
			U_EnviaEmail("","sandra.reis@maquigeral.com.br","","","Batcol04","Erro-"+cOP+"-"+cDoc+".txt",{})
		EndIf
		lRet  := .F.
		cErro := "014"
		VTClear()
		@ 0,4 VTSay "**ERRO**"
		@ 1,0 VTSay "ERRO NUMERO"+cErro
		Sleep(3000)
	Else
		ConOut("MATA241 OK")
	Endif
//End Transaction

Return(lRet)


/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄiroP¿
//³Fazer apontamento de produção Modelo II nas operações do Roteiro ³
//³conforme o centro de trabalho.                                   ³
//³Existe um recurso para um centro de trabalho, com 1 operação     ³
//³por centro de trabalho.                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄiroPÙ
ENDDOC*/

Static Function RMATA681(aZA1REC) 
Local aVetor := {}                           
Local dData
Local lUltOper := .F.
Local lExistOper := .F.
Private  cProdApt := ""
Private lMsErroAuto := .F.      
Private cOperacao := ""                
Private cRecurso  := ""
Default aZA1REC := {}
    
SC2->(dbSetOrder(1))
If SC2->(dbSeek(xFilial("SC2")+cOP))
	cProdApt := SC2->C2_PRODUTO
    
	SB1->(DbSetOrder(1))
	SB1->(MsSeek(xFilial("SB1")+cProdApt))
	
	lExistOper := VldOperacao() 
	
	If lExistOper 
		Conout("Existe Operação Cadastrada")
	    lUltOper := (U_VUltOper(cProdApt) == cOperacao)
		Conout("Ultima Operacao" + U_VUltOper(cProdApt)) 
		dData:=dDataBase
		aVetor := {{"H6_OP"	  ,cOp  ,NIL},;
		{"H6_PRODUTO" ,cProdApt,NIL},;
		{"H6_OPERAC" ,cOperacao ,NIL},;
		{"H6_RECURSO" ,cRecurso ,NIL},;
		{"H6_DTAPONT" ,dData	,NIL},;
		{"H6_DATAINI" ,dData    ,NIL},;
		{"H6_HORAINI",cHoraApt      ,NIL},;
		{"H6_DATAFIN",dData ,NIL},;
		{"H6_HORAFIN",ZA1->ZA1_HORA  ,NIL},;
		{"H6_PT"     ,'P',NIL}/*{"H6_PT"     ,IIF(Alltrim(cTpAp) $ "99/91" .And. !lUltOper,'T','P'),NIL}*/,;
		{"H6_LOCAL"  ,"01" ,NIL},;      
		{"H6_REFIZA1",aZA1REC[1,1],Nil},;
		{"H6_REFFZA1",aZA1REC[2,1],Nil},;
		{"H6_QTDPROD",0,NIL}}//{"H6_QTDPROD",IIF(Alltrim(cTpAp) $ "99/91" .And. !lUltOper,nQtdOp2,0),NIL}}                                                                                           	
		
		MSExecAuto({|x| mata681(x)},aVetor)  
		// inclusão///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		If lMsErroAuto    
			Conout("Erro apontamento - " + 	"ERRO EXECAUTO ATA681")
			MostraErro("\erros\","Erro-"+cOP+"-"+cCTrab+".txt")
			//DisarmTransaction()
			lRet  := .F.
			cErro := "014"
			VTClear()
			@ 0,4 VTSay "**ERRO**"
			@ 1,0 VTSay "ERRO "+cErro+" APT PRD
			Sleep(1000)
			lRet := .F.
		Else
			lRet := .T.
		Endif
	Else           
		Conout("Não existe operação cadastrada para esse centro de trabalho")
		cErro := "014"
		VTClear()
		@ 0,4 VTSay "**ERRO**"
		@ 1,0 VTSay "ERRO NUMERO 019"
		Sleep(3000)
		lRet := .F.    	
	EndIf	
Else
	VTClear()
	@ 0,4 VTSay "**ERRO**"
	@ 1,0 VTSay "OP N/ENCOTRADA"
	Sleep(3000)
	lRet := .F.
EndIf	
Return lRet


/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verificar qual é a última operação do roteiro.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
User Function VUltOper(cProd)
Local cUltOper 	:= "" 
Local cQryG2	:= ""
Local aAreaAtu 	:= GetArea()
Default cProd := ""                                

cQryG2 := " SELECT MAX(G2_OPERAC) G2_OPERAC "
cQryG2 += " FROM " + RetSqlName("SG2") + " SG2 "
cQryG2 += " WHERE SG2.D_E_L_E_T_='' AND SG2.G2_FILIAL  ='" + xFilial("SG2") + "' AND SG2.G2_PRODUTO = '" + cProd + "' "
If Select("TMPG2") > 0 
	TMPG2->(DbCloseArea())
EndIf                     
TCQUERY cQryG2 NEW ALIAS "TMPG2"
If TMPG2->(!EOF())
	cUltOper := TMPG2->G2_OPERAC     	
Endif
If Select("TMPG2") > 0 
	TMPG2->(DbCloseArea())
EndIf                     
RestArea(aAreaAtu)
Return cUltOper


/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ9C>¿
//³Validar se Existe operação cadastrada para o Produto.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ9C>Ù
ENDDOC*/

Static Function VldOperacao(cOperac)
Local lRet := .F.
Local cQrySel := ""
Default cOperac := ""

cQrySel := " SELECT G2_PRODUTO,G2_CTRAB,G2_OPERAC,G2_RECURSO "
cQrySel += " FROM " + RetSqlName("SG2") + " SG2 "
cQrySel += " WHERE SG2.D_E_L_E_T_ <> '*' AND SG2.G2_FILIAL  = '" + xFilial("SG2") + "' "
If !Empty(cOperac) 
	cQrySel += " AND SG2.G2_OPERAC = '" + Alltrim(cOperac) + "' "
	cQrySel += " AND SG2.G2_PRODUTO = '" + Alltrim(M->H6_PRODUTO)  + "' "  
Else
	cQrySel += " AND SG2.G2_CTRAB = '" + Alltrim(cCTrab) + "' "
	cQrySel += " AND SG2.G2_PRODUTO = '" + Alltrim(cProdApt)  + "' "  
EndIf

Conout(cQrySel)
If Select("TRBSEL") > 0 
	TRBSEL->(DbCloseArea())
EndIf
TCQUERY cQrySel NEW ALIAS "TRBSEL"
If TRBSEL->(!EOF())
	cOperacao := TRBSEL->G2_OPERAC  
	cRecurso  := TRBSEL->G2_RECURSO
	lRet := .T.
Else
	lRet := .F.
EndIf

Return lRet
                      
//Verifica se todas as operações estão apontadatas OK.
User Function SDOkOper(cCodProd,cNumOp)
Local lRet := .F.
Local cQryApts := ""
Local aAreaAtu	:= GetArea()
Local lTemApont := .F.
Local lOneOper  := .F.
Default cCodProd := ""
Default cNumOp   := ""

cQryOper := " SELECT COUNT(*) QTDOPER "
cQryOper += " FROM " + RetSQlName("SG2") + " SG2 "
cQryOper += " WHERE SG2.D_E_L_E_T_ <> '*' AND SG2.G2_FILIAL = '" + xFilial("SG2") + "' AND G2_PRODUTO = '" + Alltrim(cCodProd) + "' "
If Select("TOPER") > 0
	TOPER->(DbCloseArea())
EndIf                     
TCQUERY cQryOper NEW ALIAS "TOPER"
IF TOPER->(!EOF())
	lOneOper := (TOPER->QTDOPER == 1)
EndIf
If Select("TOPER") > 0
	TOPER->(DbCloseArea())
EndIf
//valido se exste apontamento das operaçoes do roteiro.
cQryApts += ENTER + " SELECT CASE WHEN APTSOP.STATUSAPT = 'SP' THEN 'SEMAPT' ELSE 'OK' END TIPOAPT,* FROM ( "
cQryApts += ENTER + " SELECT DISTINCT G2_OPERAC,ISNULL(SH6.H6_OPERAC,'SP')  STATUSAPT ,SH6.* " 
cQryApts += ENTER + " FROM " + RetSqlName("SG2") + " SG2 "
cQryApts += ENTER + " JOIN " + RetSqlName("SH6") + " SH6 ON SH6.D_E_L_E_T_ <> '*' AND SG2.G2_FILIAL = SH6.H6_FILIAL  AND SG2.G2_PRODUTO = SH6.H6_PRODUTO AND SG2.G2_OPERAC = SH6.H6_OPERAC AND SG2.G2_RECURSO = SH6.H6_RECURSO  AND H6_OP = '" + cNumOp + "' "
cQryApts += ENTER + " JOIN " + RetSqlName("SC2") + " SC2 ON SC2.C2_FILIAL = SH6.H6_FILIAL AND SC2.C2_NUM + SC2.C2_ITEM + SC2.C2_SEQUEN = SH6.H6_OP AND SG2.G2_CODIGO = SC2.C2_ROTEIRO  "
cQryApts += ENTER + " WHERE SG2.D_E_L_E_T_ <> '*' AND G2_FILIAL = '" + xFilial("SG2") + "' AND G2_PRODUTO = '" + cCodProd +  "' "
cQryApts += ENTER + " ) APTSOP  "

TCQUERY cQryApts NEW ALIAS "TOPER"

If TOPER->(!EOF())	
	lTemApont := .T.     	
Else
     lTemApont := .F.
EndIf

If Select("TOPER") > 0
	TOPER->(DbCloseArea())
EndIf
If lTemApont
	If !lOneOper
		//Valido se as operações que devem ser finalizadas foram apontadas e totalizadas.
		cQryApts := " SELECT * FROM ( "
		cQryApts += ENTER + " SELECT CASE WHEN APTSOP.STATUSAPT = 'SP' THEN 'SEMAPT' ELSE 'OK' END TIPOAPT,* FROM ( "
	 	cQryApts += ENTER + " SELECT DISTINCT G2_OPERAC,ISNULL(SH6.H6_OPERAC,'SP')  STATUSAPT ,SH6.* " 
		//cQryApts += ENTER + " SELECT G2_OPERAC,CASE WHEN ISNULL(SH6.H6_OPERAC,'SEMAPT') = 'SEMAPT' THEN 'SEMAPT' ELSE 'OK' END STATUSAPT ,SH6.* "
		cQryApts += ENTER + " FROM " + RetSqlName("SG2") + " SG2 "
		cQryApts += ENTER + " LEFT JOIN " + RetSqlName("SH6") + " SH6 ON SH6.D_E_L_E_T_ <> '*' AND SG2.G2_FILIAL = SH6.H6_FILIAL  AND SG2.G2_PRODUTO = SH6.H6_PRODUTO AND SG2.G2_OPERAC = SH6.H6_OPERAC AND SG2.G2_RECURSO = SH6.H6_RECURSO  AND H6_OP = '" + cNumOp + "' " //AND H6_PT = 'T' "
		cQryApts += ENTER + " LEFT JOIN " + RetSqlName("SC2") + " SC2 ON SC2.C2_FILIAL = SH6.H6_FILIAL AND SC2.C2_NUM + SC2.C2_ITEM + SC2.C2_SEQUEN = SH6.H6_OP AND SG2.G2_CODIGO = SC2.C2_ROTEIRO  "
		cQryApts += ENTER + " WHERE SG2.D_E_L_E_T_ <> '*' AND G2_FILIAL = '" + xFilial("SG2") + "' AND G2_PRODUTO = '" + cCodProd +  "' "
		cQryApts += ENTER + " ) APTSOP  "
		cQryApts += ENTER + " 	)TPAPT  "
		cQryApts += ENTER + " WHERE TPAPT.TIPOAPT = 'SEMAPT' "
	
		If Select("TAPTOP") > 0 
			TAPTOP->(DbCloseArea())
		EndIf
		TCQUERY cQryApts NEW ALIAS "TAPTOP"
		If TAPTOP->(EOF())
			//Se a area veio vazia, é sinal que está tudo ok, caso contrario tem apontamentos em aberto.
			cQryApt := " SELECT G2_OPERAC,H6_TIPO "
			cQryApt += ENTER + " FROM " + RetSQlName("SG2") + " SG2  "
			cQryApt += ENTER + " LEFT JOIN SH6010 SH6 ON SH6.D_E_L_E_T_ <> '*' AND SG2.G2_FILIAL = SH6.H6_FILIAL  AND SG2.G2_PRODUTO = SH6.H6_PRODUTO AND SG2.G2_OPERAC = SH6.H6_OPERAC AND SG2.G2_RECURSO = SH6.H6_RECURSO  AND H6_OP = '" + cNumOp + "' AND H6_PT = 'P' "
			cQryApt += ENTER + " LEFT JOIN SC2010 SC2 ON SC2.C2_FILIAL = SH6.H6_FILIAL AND SC2.C2_NUM + SC2.C2_ITEM + SC2.C2_SEQUEN = SH6.H6_OP AND SG2.G2_CODIGO = SC2.C2_ROTEIRO  "
			cQryApt += ENTER + " WHERE SG2.D_E_L_E_T_ <> '*' AND G2_FILIAL = '21'  AND G2_PRODUTO = '" + cCodProd +  "' "
			cQryApt += ENTER + " GROUP BY G2_OPERAC,H6_TIPO "
			cQryApt += ENTER + " ORDER BY G2_OPERAC,H6_TIPO "
			If Select("TMPAPT") > 0 
				TMPAPT->(DbCloseArea())			
			EndIf                      
			TCQUERY cQryApt NEW ALIAS "TMPAPT" 
			If TMPAPT->(!EOF())
			   While TMPAPT->(!EOF())
			        cOperac := TMPAPT->G2_OPERAC
			        If !Empty(Alltrim(cOperac)) .And. Alltrim(cOperac) <> Alltrim(U_VUltOper(cCodProd))
						lRetProd := U_AProd681(cCodProd,cOperac,cNumOp)			        
			        EndIf
			   		TMPAPT->(DbSkip())
			   EndDo 
			EndIf			
			If Select("TMPAPT") > 0 
				TMPAPT->(DbCloseArea())			
			EndIf                      			
			lRet := .T.                                               
		Else	          
			nQtdReg := 0  
			cOprac  := ""
			While TAPTOP->(!EOF())
				cOprac := Alltrim(TAPTOP->G2_OPERAC)
			    nQtdReg ++ 
			    TAPTOP->(DbSkip())
			EndDo       
			
			If nQtdReg == 1 .And. Alltrim(cOprac) == Alltrim(U_VUltOper(cCodProd))
				//Valido se as parciais da última operação foram apontadas para permitir a finalização da OP.
				cQryApts := " SELECT * FROM ( "
				cQryApts += ENTER + " SELECT CASE WHEN APTSOP.STATUSAPT = 'SP' THEN 'SEMAPT' ELSE 'OK' END TIPOAPT,* FROM ( "
			 	cQryApts += ENTER + " SELECT DISTINCT G2_OPERAC,ISNULL(SH6.H6_OPERAC,'SP')  STATUSAPT ,SH6.* " 
				//cQryApts += ENTER + " SELECT G2_OPERAC,CASE WHEN ISNULL(SH6.H6_OPERAC,'SEMAPT') = 'SEMAPT' THEN 'SEMAPT' ELSE 'OK' END STATUSAPT ,SH6.* "
				cQryApts += ENTER + " FROM " + RetSqlName("SG2") + " SG2 "
				cQryApts += ENTER + " LEFT JOIN " + RetSqlName("SH6") + " SH6 ON SH6.D_E_L_E_T_ <> '*' AND SG2.G2_FILIAL = SH6.H6_FILIAL  AND SG2.G2_PRODUTO = SH6.H6_PRODUTO AND SG2.G2_OPERAC = SH6.H6_OPERAC AND SG2.G2_RECURSO = SH6.H6_RECURSO  AND H6_OP = '" + cNumOp + "' AND H6_PT = 'P' "
				cQryApts += ENTER + " LEFT JOIN " + RetSqlName("SC2") + " SC2 ON SC2.C2_FILIAL = SH6.H6_FILIAL AND SC2.C2_NUM + SC2.C2_ITEM + SC2.C2_SEQUEN = SH6.H6_OP AND SG2.G2_CODIGO = SC2.C2_ROTEIRO  "
				cQryApts += ENTER + " WHERE SG2.D_E_L_E_T_ <> '*' AND G2_FILIAL = '" + xFilial("SG2") + "' AND G2_PRODUTO = '" + cCodProd +  "' AND G2_OPERAC = '"  + Alltrim(cOprac) +  "' "
				cQryApts += ENTER + " ) APTSOP  "
				cQryApts += ENTER + " 	)TPAPT  "
				cQryApts += ENTER + " WHERE TPAPT.TIPOAPT = 'SEMAPT' "
			
				If Select("TAPTOP2") > 0 
					TAPTOP2->(DbCloseArea())
				EndIf
				TCQUERY cQryApts NEW ALIAS "TAPTOP2"
				If TAPTOP2->(EOF())
					//Se a area veio vazia, é sinal que está tudo ok, caso contrario tem apontamentos em aberto.
					cQryApt := " SELECT G2_OPERAC,H6_TIPO "
					cQryApt += ENTER + " FROM " + RetSQlName("SG2") + " SG2  "
					cQryApt += ENTER + " LEFT JOIN SH6010 SH6 ON SH6.D_E_L_E_T_ <> '*' AND SG2.G2_FILIAL = SH6.H6_FILIAL  AND SG2.G2_PRODUTO = SH6.H6_PRODUTO AND SG2.G2_OPERAC = SH6.H6_OPERAC AND SG2.G2_RECURSO = SH6.H6_RECURSO  AND H6_OP = '" + cNumOp + "' AND H6_PT = 'P' "
					cQryApt += ENTER + " LEFT JOIN SC2010 SC2 ON SC2.C2_FILIAL = SH6.H6_FILIAL AND SC2.C2_NUM + SC2.C2_ITEM + SC2.C2_SEQUEN = SH6.H6_OP AND SG2.G2_CODIGO = SC2.C2_ROTEIRO  "
					cQryApt += ENTER + " WHERE SG2.D_E_L_E_T_ <> '*' AND G2_FILIAL = '21'  AND G2_PRODUTO = '" + cCodProd +  "' "
					cQryApt += ENTER + " GROUP BY G2_OPERAC,H6_TIPO "
					cQryApt += ENTER + " ORDER BY G2_OPERAC,H6_TIPO "
					If Select("TMPAPT") > 0 
						TMPAPT->(DbCloseArea())			
					EndIf                      
					TCQUERY cQryApt NEW ALIAS "TMPAPT" 
					If TMPAPT->(!EOF())
					   While TMPAPT->(!EOF())
					        cOperac := TMPAPT->G2_OPERAC
					        If !Empty(Alltrim(cOperac)) .And. Alltrim(cOperac) <> Alltrim(U_VUltOper(cCodProd))
								lRetProd := U_AProd681(cCodProd,cOperac,cNumOp)			        
					        EndIf
					   		If lRetProd
					   		   Exit
					   		EndIf
					   		TMPAPT->(DbSkip())
					   EndDo 
					EndIf			
					If Select("TMPAPT") > 0 
						TMPAPT->(DbCloseArea())			
					EndIf                      					
					
					//Se a area veio vazia, é sinal que está tudo ok, caso contrario tem apontamentos em aberto.
					lRet := lRetProd
				Else	          
					If !IsBlind()
						MsgStop("Existem operações que não foram apontadas ou finalizadas, favor verificar o roteiro e as operações do Produto","Operações em Aberto")
					Else
						Conout("ERRO Validação Operacoes -> Existem operações que não foram apontadas ou finalizadas, favor verificar o roteiro e as operações do Produto")	
					EndIf
					lRet := .F. 
				Endif 
				TAPTOP2->(DbCloseArea())                                                
			Else
				If !IsBlind()
					MsgStop("Existem operações que não foram apontadas ou finalizadas, favor verificar o roteiro e as operações do Produto","Operações em Aberto")
				Else
					Conout("ERRO Validação Operacoes -> Existem operações que não foram apontadas ou finalizadas, favor verificar o roteiro e as operações do Produto")	
				EndIf
				lRet := .F.                                                     
			EndIf
		EndIf              
		If Select("TAPTOP") > 0 
			TAPTOP->(DbCloseArea())
		EndIf    
	Else
		lRet := .T.
	EndIf	       
Else

	If !IsBlind()
		MsgStop("Existem operações que não foram apontadas ou finalizadas, favor verificar o roteiro e as operações do Produto","Operações em Aberto")
	Else
		Conout("ERRO Validação Operacoes -> Existem operações que não foram apontadas ou finalizadas, favor verificar o roteiro e as operações do Produto")	
	EndIf
	lRet := .F.                                                     	
EndIf	
RestArea(aAreaAtu)
Return lRet                                                      

User Function AProd681(cCodProd,cOperac,cOp)
Local aVetor := {}                           
Local dData            
Local lExistOper := .F.
Local lOpontOK := .F.
Private cOperacao := ""
Private cRecurso  := ""
Private lMsErroAuto := .F.      

Default cCodProd := ""
Default cOperac  := ""
		
lExistOper := VldOperacao(cOperac)
If lExistOper	
		dData:=dDataBase
		aVetor := {{"H6_OP"	  ,cOp  ,NIL},;
		{"H6_PRODUTO" ,cCodProd,NIL},;
		{"H6_OPERAC" ,cOperacao ,NIL},;
		{"H6_RECURSO" ,cRecurso ,NIL},;
		{"H6_DTAPONT" ,dData	,NIL},;
		{"H6_DATAINI" ,dData    ,NIL},;		
		{"H6_DATAFIN",dData ,NIL},;		
		{"H6_PT"     ,'T',NIL}/*{"H6_PT"     ,IIF(Alltrim(cTpAp) $ "99/91" .And. !lUltOper,'T','P'),NIL}*/,;
		{"H6_LOCAL"  ,"01" ,NIL},;      
		{"H6_QTDPROD",1,NIL}}//{"H6_QTDPROD",IIF(Alltrim(cTpAp) $ "99/91" .And. !lUltOper,nQtdOp2,0),NIL}}                                                                                           	
		
		MSExecAuto({|x| mata681(x)},aVetor)  
		// inclusão///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		If lMsErroAuto    
			Conout("Erro apontamento - " + 	"ERRO EXECAUTO ATA681")
			MostraErro("\erros\","Erro-"+cOP+"-"+cOperacao+".txt")
        Else
        	lOpontOK := .T.
        EndIf
EndIf
Return lOpontOK  


User Function SDTemOper(cCodProd)
Local cQuery := ""
Local lRet   := IIF(SuperGetMV("SD_VLDOPER",.F.,.F.),.F.,.t.)
Local aGetArea := GetArea()
Default cCodProd := ""
If !Empty(Alltrim(cCodProd)) .And. !IsBlind()
cQuery := " SELECT G2_PRODUTO,COUNT(*) QTDOPERAC  "
cQuery += " FROM " + RetSqlName("SG2") + " SG2 "
cQuery += " WHERE D_E_L_E_T_ <> '*' AND LTRIM(RTRIM(G2_PRODUTO)) = '" + Alltrim(cCodProd) + "' "        
cQuery += " GROUP BY G2_PRODUTO "
If Select("TMPG2") > 0 
    TMPG2->(DbCloseArea())
EndIf                     
TCQUERY cQuery NEW ALIAS "TMPG2"
If TMPG2->(!EOF())
	lRet := .T.
Else	
	//incluido a validação dos grupos de ACESSORIOS,INSTALAÇÃO E SOBRESSALENTES, pois os mesmos nao possuem roteiro.
	DbSelectArea("SB1")
	SB1->(DbGotop())
	SB1->(DbSetOrder(1))
	If SB1->(DbSeek(xFilial("SB1")+Alltrim(cCodProd))) .And. SB1->B1_GRUPO $ "2042/2043/2044"
		lRet := .T.
	Else
		MsgStop("Não existe roteiro de operações cadastrado para esse produto.","Roteiro de Operações")
	EndIf
EndIf                                                          


If Select("TMPG2") > 0 
    TMPG2->(DbCloseArea())
EndIf                     
Else
	lRet := .T.
EndIf
RestArea(aGetArea)
Return lRet
