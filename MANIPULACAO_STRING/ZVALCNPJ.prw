#INCLUDE "PROTHEUS.CH"



/*
+============================================================================================================+
| Função: [ zValCnpj ]                                                                                       |
| Função: [ Verifica se existe o cnpj com a mesma raiz e mantem o código e muda a loja ]                     |
| Autor:  [ FERNANDO JOSE RODRIGUES ]                                                                        |
| Data Criacao: [ 02/06/2022 ]                                                                               |
| Última Alteração: [  ]                                                                                     |
+============================================================================================================+
*/

User Function zValCnpj()
    Local cAreaAnt, aAreaSA2, cCodigo, cLoja, cChave
    
    If INCLUI
       
        If Empty(M->A2_CGC)
            cCodigo := M->A2_COD
            cLoja := M->A2_LOJA
        Else
            // Salva o ambiente
            cAreaAnt := alias()
            aAreaSA2 := SA2->(Getarea())
            
            If M->A2_TIPO == "J"        // Pessoa Juridica
               cChave := Left(M->A2_CGC,8)
            Endif
            If M->A2_TIPO == "F"
               cChave := M->A2_CGC
            Endif
            If M->A2_TIPO == "X"
               cCodigo := M->A2_COD
            Endif
            
            If M->A2_TIPO == "J" .OR. M->A2_TIPO == "F"
               // Verifica se aproveita codigo ja existente
               dbSelectArea("SA2")
               dbSetOrder(3)   // A2_FILIAL+A2_CGC
               If dbSeek(xFilial("SA2")+cChave,.F.)
                    cCodigo := SA2->A2_COD
                    cLoja := SA2->A2_LOJA
               Else
                    cCodigo := M->A2_COD
               Endif
            Endif
            
            
               //If M->A2_TIPO == "J"        // Pessoa Juridica
               //     cLoja := Substring(M->A2_CGC,11,2)
               //Else
              //    cLoja := "0001"
               // Endif
            
            
            // Restaura o ambiente
            Restarea(aAreaSA2)
            dbSelectArea(cAreaAnt)
            
        Endif
       
        // Atualiza o codigo e a loja do fornecedor
        M->A2_COD := cCodigo
        M->A2_LOJA := cLoja
       
    Endif
Return .T.
