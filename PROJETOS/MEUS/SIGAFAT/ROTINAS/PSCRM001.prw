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
    //Local aAreaSA1 := GetArea("SA1")
    //Local aAreaSA2 := SA2->(GetArea())
    Local cCodigo  := ""
    Local cLoja    := ""
    Local nCont    := 1
    Local lCheck   := .F.
    Local cQrySA1  := ""
    Local cQrySA2  := ""
    Local nTotal   := 0
    Local cCgcSA1  := ""
    Local cCgcSA2  := ""



If FunName() == "CRMA980" .OR. FunName() == "MATA030"

    cCgcSA1 := Left(M->A1_CGC, 8)

    cQrySA1 := " SELECT " + CRLF
    cQrySA1 += "    A1_COD, " + CRLF
    cQrySA1 += "    A1_LOJA, " + CRLF
    cQrySA1 += "    A1_NOME, " + CRLF
    cQrySA1 += "    A1_CGC " + CRLF
    cQrySA1 += " FROM " + RetSqlName('SA1') + " SA1" + CRLF
    cQrySA1 += " WHERE " + CRLF
    cQrySA1 += "    A1_FILIAL = '" + FWxFilial('SA1') + "' " + CRLF
    cQrySA1 += "    AND LEFT(A1_CGC, 8) = '" + cCgcSA1 + "' " + CRLF
    cQrySA1 += "    AND D_E_L_E_T_ <> '*' " 

    MemoWrite("cPsCrm001.SQL", cQrySA1)

    TCQuery cQrySA1 New Alias "QRY_SA1"

    DbSelectArea("QRY_SA1")

    Count To nTotal

    QRY_SA1->(DbGoTop())
    
  
    While ! QRY_SA1->(Eof()) .And. cCodigo = ""
         
         nCont++
        
      
 
         If Left(M->A1_CGC,8) == Left(QRY_SA1->A1_CGC, 8)

                 cCodigo :=  QRY_SA1->A1_COD
                 cLoja := StrZero(nTotal + 1, Len(SA1->A1_LOJA)) 
                 lCheck := .T.
         EndIf
         SA1->(DbSkip())
     EndDo

     If lCheck == .F.
         cCodigo := GetSxeNum("SA1","A1_COD")       
         cLoja   := StrZero(1, Len(SA1->A1_LOJA))
     EndIf

     FwFldPut("A1_LOJA", cLoja)
     FwFldPut("A1_COD", cCodigo)
     
    QRY_SA1->(DbCloseArea())

ElseIf FunName() == "MATA020"

    cCgcSA2 := Left(M->A2_CGC, 8)

    cQrySA2 := " SELECT " + CRLF
    cQrySA2 += "    A2_COD, " + CRLF
    cQrySA2 += "    A2_LOJA, " + CRLF
    cQrySA2 += "    A2_NOME, " + CRLF
    cQrySA2 += "    A2_CGC " + CRLF
    cQrySA2 += " FROM " + RetSqlName('SA2') + " SA2" + CRLF
    cQrySA2 += " WHERE " + CRLF
    cQrySA2 += "    A2_FILIAL = '" + FWxFilial('SA2') + "' " + CRLF
    cQrySA2 += "    AND LEFT(A2_CGC, 8) = '" + cCgcSA2 + "' " + CRLF
    cQrySA2 += "    AND D_E_L_E_T_ <> '*' " 

    MemoWrite("cPsCrm001.SQL", cQrySA2)

    TCQuery cQrySA2 New Alias "QRY_SA2"

    DbSelectArea("QRY_SA2")
    
    Count To nTotal

    QRY_SA2->(DbGoTop())
    
    While ! QRY_SA2->(Eof()) .And. cCodigo = ""
         
         nCont++    
 
         If Left(M->A2_CGC,8) == Left(QRY_SA2->A2_CGC, 8)

                cCodigo :=  QRY_SA2->A2_COD
                cLoja := StrZero(nTotal + 1, Len(SA2->A2_LOJA)) 
                lCheck := .T.

         EndIf
         QRY_SA2->(DbSkip())
    EndDo

     If lCheck == .F.
         cCodigo := GetSxeNum("SA2","A2_COD")       
         cLoja := StrZero(1, Len(SA2->A2_LOJA))
     EndIf

     FwFldPut("A2_LOJA", cLoja)
     FwFldPut("A2_COD", cCodigo)

    QRY_SA2->(DbCloseArea())
    

EndIf

    
    
    //RestArea(aAreaSA2)
    //RestArea(aAreaSA1)
    RestArea(aArea)
    
Return cCodigo
