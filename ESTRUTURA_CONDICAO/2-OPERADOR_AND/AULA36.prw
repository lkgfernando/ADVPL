#Include "Protheus.ch"


/*###############################################################################
| Exemplo com condi��o IF utilizando o .AND.
#################################################################################
*/
User Function AULA36()
Local nMaioridade := 1 // SIM
Local nIngresso := 0 // N�O

if nMaioridade = 1 .And. nIngresso = 1
    MsgInfo("Lest's go to the Party", "Liberado")
else
    MsgInfo("Barrado no baile", "Bloqueado")
endif

Return
