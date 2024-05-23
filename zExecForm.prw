#Include "PROTHEUS.CH"
//--------------------------------------------------------------
/*/{Protheus.doc} MyFunction
Description

@param xParam Parameter Description
@return xRet Return Description
@author  Fernando José rodrigues
@since 27/04/2023
/*/
//--------------------------------------------------------------
User Function zExecForm()
Local aArea := FWGetArea()
Private oDlgForm
Private oGrpForm
Private oGetForm
Private cGetForm := Space(250)
Private oGrpAco
Private oBtnExec
//Configuração da Janela
Private nJanLarg := 500
Private nJanAltu := 120
Private nJanMeio := ((nJanLarg) / 2) /2
Private nTamBtn  := 048

  DEFINE MSDIALOG oDlgForm TITLE "Execução de formulas" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL

    @ 003, 003 GROUP oGrpForm TO 030, (nJanLarg/2)-1 PROMPT "Fórmula:" OF oDlgForm COLOR 0, 16777215 PIXEL
    @ 010, 006 MSGET oGetForm VAR cGetForm SIZE (nJanLarg/2)-9, 013 OF oDlgForm COLORS 0, 16777215 PIXEL
    
    @ (nJanAltu/2)-30, 003 GROUP oGrpAco TO (nJanAltu/2)-3, (nJanLarg/2)-1 PROMPT "Ações" OF oDlgForm COLOR 0, 16777215 PIXEL
    @ (nJanAltu/2)-24, nJanMeio - (nTamBtn/2) BUTTON oBtnExec PROMPT "Executar" SIZE nTamBtn, 018 OF oDlgForm ACTION (fExecuta()) PIXEL

    

  ACTIVATE MSDIALOG oDlgForm CENTERED

FWRestArea(aArea)
Return


/*/{Protheus.doc} fExecuta
    (long_description)
    @type  Static Function
    @author Fernando José Rodrigues
    @since 27/04/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fExecuta()
    Local aArea := FWGetArea()
    Local cFormula := AllTrim(cGetForm)
    Local cError := ""
    Local bError := ErrorBlock( { |oError| cError := oError:Description } )

    If ! Empty(cFormula)
        Begin Sequence
            &(cformula)
        End Sequence

        ErrorBlock(bError)

        If ! Empty(cError)
            MsgStop("Houve um erro na fórmula digitada: " +CRLF+CRLF+cError, "Atenção")
        EndIf

    EndIf

    FWRestArea(aArea)
Return 
