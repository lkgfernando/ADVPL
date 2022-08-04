#INCLUDE "PROTHEUS.CH"

/*
// ##############################################################################################
// Projeto: Exemplo de como utilizar o MsNewProcess
// Modulo : SIGAATF
// Fonte  : zPBMsN
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 03/08/2022   | FERNANDO RODRIGUES | EXEMPLO PARA ESTUDOS
// -------------+----------------------+---------------------------------------------------------*/ 


User Function zPBMsN()
    
    Private oProcess := NIL
    oProcess := MsNewProcess():New({|lEnd| RunProc(lEnd,oProcess)}, "Processando", "Lendo...", .T.)
    oProcess:Activate()

Return


Static Function RunProc(lEnd,oObj)
    Local i := 0
    Local aTabela := {}
    Local nCnt := 0
    Local cFilialSX5

    aAdd(aTabela, {"00", 0, Nil})
    aAdd(aTabela, {"01", 0, Nil})
    aAdd(aTabela, {"12", 0, Nil})
    //aTabela := {{"00",0,Nil},{"01",0,Nil},{"12",0,Nil}}
    
    DbSelectArea("SX5")
    cFilialSX5 := xFilial("SX5")

    DbSetOrder(1)
    For i := 1 To Len(aTabela)
        DbSeek(cFilialSX5+aTabela[i,1])
        While !Eof() .And. X5_FILIAL+X5_TABELA == cFilialSX5+aTabela[i,1]
            If lEnd
                Exit
            EndIf
            nCnt++
            DbSkip()
        End
        aTabela[i,2] := nCnt
        nCnt := 0
    Next i

    oObj:SetRegua1(Len(aTabela))

    For i := 1 To Len(aTabela)
        If lEnd
            Exit
        EndIf
        oObj:IncRegua1("Lendo Tabela: " + aTabela[i, 1])
        DbSelectArea("SX5")
        DbSeek(cFilialSX5 + aTabela[i,1])
        oObj:SetRegua2(aTabela[i, 2])
        While !Eof() .And. X5_FILIAL + X5_TABELA == cFilialSX5 + aTabela[i, 1]
            oObj:IncRegua2("Lendo chave: " + X5_CHAVE)
            If lEnd
                Exit
            EndIf
            DbSkip()
        End
    Next i

Return
