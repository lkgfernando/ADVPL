#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RFATR010 º Autor ³Bruno Daniel Borges º Data ³  01/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Extrato de amortizacao                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Igaratiba                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function RFATR010()
Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := ""
Local cPict         := ""
Local titulo       	:= "Extrato de Amortização"
Local nLin         	:= 80
Local imprime      	:= .T.
Local aOrd 			:= {}

//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//0         10        20        30        40        50        60        70        80        90        100       110       120       130       140
//Data      N.F.        Produto              Quantidade           Preço           Preço           Valor
//                                                                Venda     Amortização     Amortizacao
//99/99/99  9999999999  XXXXXXXXXXXXXXX  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99
//99/99/99  9999999999  XXXXXXXXXXXXXXX  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99
//99/99/99  9999999999  XXXXXXXXXXXXXXX  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99
//99/99/99  9999999999  XXXXXXXXXXXXXXX  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99
Local Cabec1       	:= ""
Local Cabec2       	:= ""

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 132
Private tamanho      := "M"
Private nomeprog     := "RFATR010"
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "RFATR010"
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RFATR010"
Private cString      := "SD2"
                     
U_IGRotAtv('rfatr010', substr(cUsuario,7,15))

dbSelectArea("SD2")
SD2->(dbSetOrder(1))

/*
//Comentado - migracao dicionario para banco de dados

PutSx1(cPerg,"01","Do Cliente"		,"Do Cliente"		,"Do Cliente"		,"mv_ch1","C",06,0,1,"G","","SA1","","","mv_par01","","","","","","","","","","","","","","","","",{""},{""},{""})
PutSx1(cPerg,"02","Ate o Cliente"	,"Ate o Cliente"	,"Ate o Cliente"	,"mv_ch2","C",06,0,1,"G","","SA1","","","mv_par02","","","","","","","","","","","","","","","","",{""},{""},{""})
PutSx1(cPerg,"03","Do Molde"		,"Do Molde"			,"Do Molde"			,"mv_ch3","C",15,0,1,"G","","SB1","","","mv_par03","","","","","","","","","","","","","","","","",{""},{""},{""})
PutSx1(cPerg,"04","Ate o Molde"		,"Ate o Molde"		,"Ate o Molde"		,"mv_ch4","C",15,0,1,"G","","SB1","","","mv_par04","","","","","","","","","","","","","","","","",{""},{""},{""})
PutSx1(cPerg,"05","Emissao De"		,"Emissao De"		,"Emissao De"		,"mv_ch5","D",08,0,1,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{""},{""},{""})
PutSx1(cPerg,"06","Emissao Ate"		,"Emissao Ate"		,"Emissao Ate"		,"mv_ch6","D",08,0,1,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{""},{""},{""})
//Fim alteracao - migracao dicionario para banco de dados
*/

Pergunte(cPerg,.F.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³Bruno Daniel Borges º Data ³  01/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Processamento do relatorio                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)     
Local cQuery  := ""   
Local cQuebra := ""
Local bQuery  := {|| Iif(Select("TMP_AMT") > 0, TMP_AMT->(dbCloseArea()), Nil), &('dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery), "TMP_AMT",.F.,.T.)') , dbSelectArea("TMP_AMT"),TMP_AMT->(dbEval({|| nTotReg++ })) ,TMP_AMT->(dbGoTop())}
Local nTotReg := 0    
Local aTotais := {0,0,0,0}

//Query do relatorio
cQuery := " SELECT D2_EMISSAO, D2_DOC, D2_COD, (D2_XQTDAMT - D2_QTDEDEV) AS D2_XQTDAMT, D2_TOTAL, (D2_XAMORT / CASE WHEN D2_XQTDAMT = 0 THEN 1 ELSE D2_XQTDAMT END * (D2_XQTDAMT - D2_QTDEDEV)) AS D2_XAMORT, "
cQuery += "        B1_DESC, A1_NOME, B1_VLRADT, B1_VLRUNT, B1_XSALDO, B1_PICM, D2_CLIENTE, D2_LOJA, D2_PRCVEN "
cQuery += " FROM " + RetSQLName("SD2") + " A, " + RetSQLName("SB1") + " B, " + RetSQLName("SA1") + " C, " + RetSQLName("SZ3") + " D " 
cQuery += " WHERE D2_FILIAL = '" + xFilial("SD2") + "' AND D2_EMISSAO BETWEEN '" + DToS(mv_par05) + "' AND '" + DToS(mv_par06) + "' AND "
cQuery += "       D2_COD = Z3_PRODUTO AND "
cQuery += "       D2_CLIENTE BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' AND "
cQuery += "       A.D_E_L_E_T_ = ' ' AND "
cQuery += "       B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = Z3_MOLDE AND B.D_E_L_E_T_ = ' ' AND "
cQuery += "       A1_FILIAL = '" + xFilial("SA1") + "' AND A1_COD = D2_CLIENTE AND A1_LOJA = D2_LOJA AND C.D_E_L_E_T_ = ' ' AND "
cQuery += "       Z3_FILIAL = '" + xFilial("SZ3") + "' AND Z3_MOLDE BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "' AND D.D_E_L_E_T_ = ' ' "
cQuery += " ORDER BY D2_CLIENTE, D2_LOJA, D2_COD "
LJMsgRun("Buscando Dados...","Aguarde...",bQuery)

SetRegua(nTotReg)

While TMP_AMT->(!Eof())
	cQuebra := TMP_AMT->D2_CLIENTE + TMP_AMT->D2_LOJA + TMP_AMT->D2_COD

	//Forca a quebra de pagina	
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 9                
	
	@ nLin  ,000 PSay "Cliente:       " + AllTrim(TMP_AMT->D2_CLIENTE) + " - " + TMP_AMT->A1_NOME
	@ nLin+1,000 PSay "Produto:       " + AllTrim(TMP_AMT->D2_COD) + " - " + TMP_AMT->B1_DESC
	@ nLin+2,000 PSay "Valor Molde:   " + Transform(TMP_AMT->B1_VLRUNT * TMP_AMT->B1_VLRADT ,"@E 999,999,999.99") + "    Qtde. Amortizar: " + Transform(TMP_AMT->B1_XSALDO ,"@E 999,999,999.99")
	@ nLin+3,000 PSay "Data Cadastro:         % ICMS: "  + Transform(TMP_AMT->B1_PICM,"@E 999.99") + "     Situação: " + IIf(TMP_AMT->B1_XSALDO > 0,"Em Aberto","Encerrado")
	
	nLin += 4
	                                                                                                                       
	@ nLin  ,000 PSay Replicate("-",132)
	@ nLin+1,000 PSay "Data      N.F.        Produto              Quantidade           Preço           Preço           Valor"
	@ nLin+2,000 PSay "                                                                Venda     Amortização     Amortizacao"
	@ nLin+3,000 PSay Replicate("-",132)
	
	nLin += 4
	aTotais := {0,0,0,0}

	//Impressao do relatorio	
	While TMP_AMT->(!Eof()) .And. TMP_AMT->D2_CLIENTE + TMP_AMT->D2_LOJA + TMP_AMT->D2_COD == cQuebra
		IncRegua()                  
		
		//Testa devolucao
		If TMP_AMT->D2_XQTDAMT <= 0
			TMP_AMT->(dbSkip())
			Loop
		EndIf
		
   		If lAbortPrint
      		@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      		Exit
   		Endif

   		If nLin > 60
      		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      		nLin := 9
   		Endif
   		
   		@ nLin,000 PSay DToC(SToD(TMP_AMT->D2_EMISSAO))
   		@ nLin,010 PSay TMP_AMT->D2_DOC
   		@ nLin,022 PSay TMP_AMT->D2_COD
   		@ nLin,039 PSay Transform(TMP_AMT->D2_XQTDAMT,"@E 999,999,999.99") 
   		@ nLin,055 PSay Transform(TMP_AMT->D2_PRCVEN,"@E 999,999,999.99") 
   		@ nLin,071 PSay Transform(TMP_AMT->D2_XAMORT / TMP_AMT->D2_XQTDAMT,"@E 999,999,999.99") 
   		@ nLin,087 PSay Transform(TMP_AMT->D2_XAMORT,"@E 999,999,999.99") 
   		nLin++
   		
   		aTotais[1] += TMP_AMT->D2_PRCVEN
   		aTotais[2] += (TMP_AMT->D2_XAMORT / TMP_AMT->D2_XQTDAMT)
   		aTotais[3] += TMP_AMT->D2_XAMORT
   		aTotais[4] += TMP_AMT->D2_XQTDAMT

   		TMP_AMT->(dbSkip())
	EndDo
	
	If nLin+1 > 60
    	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      	nLin := 9
 	Endif    
 	
 	@ nLin,000 PSay Replicate("-",132)
 	nLin++ 	
 	@ nLin,000 PSay "Total Geral" 	  
 	@ nLin,039 PSay Transform(aTotais[4],"@E 999,999,999.99") 
  	@ nLin,055 PSay Transform(aTotais[1],"@E 999,999,999.99") 
  	@ nLin,071 PSay Transform(aTotais[2],"@E 999,999,999.99") 
  	@ nLin,087 PSay Transform(aTotais[3],"@E 999,999,999.99") 
  	nLin++
EndDo

Set Device To Screen

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return
