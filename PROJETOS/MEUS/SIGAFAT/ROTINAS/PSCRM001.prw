#Include "Totvs.ch"
#Include "TopConn.ch"



/*/{Protheus.doc} User Function PsCrm001
    Função que verifica grupo de cliente pelo CNPJ, para manter o mesmo código.
    @type  Function
    @author Fernando Jose Rodrigues
    @since 22/09/2022
    /*/
User Function PsCrm001()
    Local aArea    := GetArea()
    Local aAreaSA1 := GetArea("SA1")
    Local aAreaSA2 := SA2->(GetArea())
    Local cCodigo  := ""
    Local cLoja    := ""
    Local nCont    := 1
    Local lCheck   := .F.


If FunName() == "CRMA980"

    DbSelectArea("SA1")
    DbSetOrder(3)
    SA1->(DbGoTop())
    SA1->(DbSeek(xFilial("SA1") + Left(SA1->A1_CGC,8))) 
  
  
    While SA1->(!Eof()) .And. Left(M->A1_CGC,8) == Left(SA1->A1_CGC, 8)
         
         nCont++
         cCodigo :=  SA1->A1_COD
      
 
         If Left(M->A1_CGC,8) == Left(SA1->A1_CGC, 8)
              
                 If nCont < 10
                     cLoja := "000" + cValToChar(nCont)
                 elseIf nCont > 10 .And. nCont < 100
                     cLoja := "00" + cValToChar(nCont)
                 else
                     cLoja := "0" + cValToChar(nCont)
                 EndIf
                 lCheck := .T.
         EndIf
         SA1->(DbSkip())
     EndDo

     If lCheck == .F.
         cCodigo := GetSxeNum("SA1","A1_COD")       
         cLoja := "0001"
     EndIf

     FwFldPut("A1_LOJA", cLoja)
     FwFldPut("A1_COD", cCodigo)

ElseIf FunName() == "MATA020"

    DbSelectArea("SA2")
    DbSetOrder(3)
    SA2->(DbGoTop())
    SA2->(DbSeek(xFilial("SA2") + Left(SA2->A2_CGC,8))) 
  
  
    While SA2->(!Eof()) .And. Left(M->A2_CGC,8) == Left(SA2->A2_CGC, 8)
         
         nCont++
         cCodigo :=  SA2->A2_COD
      
 
         If Left(M->A2_CGC,8) == Left(SA2->A2_CGC, 8)
              
                 If nCont < 10
                     cLoja := "000" + cValToChar(nCont)
                 elseIf nCont > 10 .And. nCont < 100
                     cLoja := "00" + cValToChar(nCont)
                 else
                     cLoja := "0" + cValToChar(nCont)
                 EndIf
                 lCheck := .T.
         EndIf
         SA1->(DbSkip())
     EndDo

     If lCheck == .F.
         cCodigo := GetSxeNum("SA2","A2_COD")       
         cLoja := "0001"
     EndIf

     FwFldPut("A2_LOJA", cLoja)
     FwFldPut("A2_COD", cCodigo)




EndIf

    RestArea(aAreaSA2)
    RestArea(aAreaSA1)
    RestArea(aArea)
    
Return cCodigo
