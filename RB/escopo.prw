#INCLUDE "PROTHEUS.CH"

STATIC cTexto := "Estatica"

/*/{Protheus.doc} User Function nomeFunction
    (long_description)
    @type  Function
    @author user
    @since 28/04/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zESCOPO()
    LOCAL nNumero := 10
    PRIVATE dData := Date()
    
    If nNumero >= 10.5
        Alert('nNumero é maoir')
    else
        Alert('nNumero é Menor')
    EndIf

    zFILHA()

Return

Static Function zFILHA()
    LOCAL nNumero := 20
    PRIVATE lContinua := .T.
    PUBLIC _aDados := {1,3,7}

    if lContinua = .F.
        Alert('lContinua é FALSE')
    else
        Alert('lContinua é TRUE')
    EndIf

    cTexto := 'Alterado'

    U_zSECUNDARIA()
Return

User Function zSECUNDARIA()
    LOCAL cTexto := 'ATEU OU AO MEU OU AO SEU'
    LOCAL nNumero := 30
    _aDados := {0,0,0}

    if "ATEU" $ cTexto
        Alert('A palavra ATEU está contida na  cTexto')
    else
        Alert('Não está contida na cTexto')
    EndIf
Return cTexto

