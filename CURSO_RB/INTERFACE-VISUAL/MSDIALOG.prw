#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"


/*
// ##############################################################################################
// Projeto: zVisual ==> Criando telas visuais com MSDIALOG
// Modulo : SIGAATF
// Fonte  : zVisual
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 01/08/2022   | FERNANDO RODRIGUES   | Telas pra validação de CNPJ
// -------------+----------------------+---------------------------------------------------------*/


User Function zVisual()

    Local cTitulo := "Aula de MSDIALOG"
    Local cTexto  := "CNPJ"
    Local cCGC    := Space(13)
    Local nOpca   := 0
    Private oDlg

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 000,000 TO 080,300 PIXEL
    @ 001,001 TO 040, 150 OF oDlg PIXEL
    @ 010,010 SAY cTexto SIZE 55, 07 OF oDlg PIXEL
    @ 010,050 MSGET cCGC SIZE 55, 11 OF oDlg PIXEL PICTURE "@R 99.999.999/9999-99" VALID zCGC(@cCGC)
    DEFINE SBUTTON FROM 010, 120 TYPE 1 ACTION (nOpca := 1, oDlg:End()) ENABLE OF oDlg
    DEFINE SBUTTON FROM 025, 120 TYPE 2 ACTION (nOpca := 2, oDlg:End()) ENABLE OF oDlg
    ACTIVATE MSDIALOG oDlg CENTERED

    If nOpca == 2
        RETURN
    EndIf

    MsgInfo("O CNPJ digitado foi: " + cCGC, "Validacao CNPJ")

Return

/*/{Protheus.doc} zCGC
    Apenas teste de validação de CGC
    @type  Static Function
    @author Fernando Josoe Rodrigues
    @since 01/08/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function zCGC(cCGC)
    If cCGC <> "11111111111111"
        MsgAlert("Erro de CNPJ", "ATENÇÃO")
        cCGC := "11111111111111"
        oDlg:Refresh()
    EndIf
Return
