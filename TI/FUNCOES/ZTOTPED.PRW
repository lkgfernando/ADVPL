#Include "Protheus.ch"
#Include "TopConn.ch"
  
/*
* Funcao			: ZTOTPED
* Autor				: Eleva Consult
* Data				: 21/06/2022
* Descricao			: Função que retorna o valor total do pedido com os impostos
* Parametros		: NA
* Retorno			: NA
* Observacoes		: NA.
*/
  
User Function zTotPed(cNumPed)
    Local aArea     := GetArea()
    Local aAreaC5   := SC5->(GetArea())
    Local aAreaB1   := SC6->(GetArea())
    Local aAreaC6   := SB1->(GetArea())
    Local aAreaZC1  := ZC1->(GetArea())
    Local cQryIte   := ""
    Local nValPed   := 0
    Local nNritem   := 0
    Default cNumPed := ZC1->ZC1_PEDIDO
    Default nTipo   := 1


        cQryIte := " SELECT "
        cQryIte += "    C6_ITEM, "
        cQryIte += "    C6_PRODUTO "
        cQryIte += " FROM "
        cQryIte += "    "+RetSQLName('SC6')+" SC6 "
        cQryIte += "    LEFT JOIN "+RetSQLName('SB1')+" SB1 ON ( "
        cQryIte += "        B1_FILIAL = '"+FWxFilial('SB1')+"' "
        cQryIte += "        AND B1_COD = SC6.C6_PRODUTO "
        cQryIte += "        AND SB1.D_E_L_E_T_ = ' ' "
        cQryIte += "    ) "
        cQryIte += " WHERE "
        cQryIte += "    C6_FILIAL = '"+FWxFilial('SC6')+"' "
        cQryIte += "    AND C6_NUM = '"+cNumPed+"' "
        cQryIte += "    AND SC6.D_E_L_E_T_ = ' ' "
        cQryIte += " ORDER BY "
        cQryIte += "    C6_ITEM "
        cQryIte := ChangeQuery(cQryIte)
        TCQuery cQryIte New Alias "QRY_ITE"
          
        DbSelectArea('SC5')
        SC5->(DbSetOrder(1))
        SC5->(DbSeek(FWxFilial('SC5') + cNumPed))
        MaFisIni(SC5->C5_CLIENTE,;                    // 1-Codigo Cliente/Fornecedor
            SC5->C5_LOJACLI,;                    // 2-Loja do Cliente/Fornecedor
            If(SC5->C5_TIPO$'DB',"F","C"),;               // 3-C:Cliente , F:Fornecedor
            SC5->C5_TIPO,;                                // 4-Tipo da NF
            SC5->C5_TIPOCLI,;                           // 5-Tipo do Cliente/Fornecedor
            MaFisRelImp("MT100",{"SF2","SD2"}),;        // 6-Relacao de Impostos que suportados no arquivo
            ,;                                               // 7-Tipo de complemento
            ,;                                            // 8-Permite Incluir Impostos no Rodape .T./.F.
            "SB1",;                                        // 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
            "MATA461")                                    // 10-Nome da rotina que esta utilizando a funcao
          
        //Pega o total de itens
        QRY_ITE->(DbGoTop())
        While ! QRY_ITE->(EoF())
            nNritem++
            QRY_ITE->(DbSkip())
        EndDo
          
        //Preenchendo o valor total
        QRY_ITE->(DbGoTop())
        nTotIPI := 0
        While ! QRY_ITE->(EoF())
            //Pega os tratamentos de impostos
            SB1->(DbSeek(FWxFilial("SB1")+QRY_ITE->C6_PRODUTO))
            SC6->(DbSeek(FWxFilial("SC6")+cNumPed+QRY_ITE->C6_ITEM))
              
            MaFisAdd(    SC6->C6_PRODUTO,;                     // 1-Codigo do Produto                 ( Obrigatorio )
                        SC6->C6_TES,;                         // 2-Codigo do TES                     ( Opcional )
                        SC6->C6_QTDVEN,;                      // 3-Quantidade                     ( Obrigatorio )
                        SC6->C6_PRCVEN,;                      // 4-Preco Unitario                 ( Obrigatorio )
                        SC6->C6_VALDESC,;                    // 5 desconto
                        SC6->C6_NFORI,;                     // 6-Numero da NF Original             ( Devolucao/Benef )
                        SC6->C6_SERIORI,;                    // 7-Serie da NF Original             ( Devolucao/Benef )
                        0,;                                    // 8-RecNo da NF Original no arq SD1/SD2
                        0,;                // 9-Valor do Frete do Item         ( Opcional )
                        0,;            // 10-Valor da Despesa do item         ( Opcional )
                        0,;            // 11-Valor do Seguro do item         ( Opcional )
                        0,;                                    // 12-Valor do Frete Autonomo         ( Opcional )
                        SC6->C6_VALOR,;                     // 13-Valor da Mercadoria             ( Obrigatorio )
                        0,;                                    // 14-Valor da Embalagem             ( Opcional )
                        0,;                                     // 15-RecNo do SB1
                        0)                                     // 16-RecNo do SF4
              
            nItem++
            QRY_ITE->(DbSkip())
        EndDo
          
        //Pegando totais
        nTotIPI   := MaFisRet(,'NF_VALIPI')
        nTotSol   := MaFisRet(,'NF_VALSOL')
        nTotNF    := MaFisRet(,'NF_TOTAL')

          
        QRY_ITE->(DbCloseArea())
        MaFisEnd()
  
    nValPed := nTotNF 

      
    RestArea(aAreaC6)
    RestArea(aAreaB1)
    RestArea(aAreaC5)
    RestArea(aAreaZC1)
    RestArea(aArea)
Return nValPed
