#Include "Protheus.ch"

/*/{Protheus.doc} lp002
(long_description)
@type user function
@author Fernando Rodrigues
@since 04/03/2025
@example
Tipos de variáveis
@see (links_or_references)
/*/
User Function lp002()
  //Numerico
  Local nValor := 9
  Local nValPF := 10.1523

  //Lógico
  Local lOk := .T.
  Local lNOk := .F.

  //Caracter
  Local cNome := "Fernando"
  Local cTexto := 'Está é uma variavel do tipo caracter'

  //Data
  Local dDataIni := cToD("12/02/2020")
  Local dDataHoje := Date()
  Local dData := SToD("20250304")

  //Matriz (Array)
  Local aNomes := {"Fernando", "Kauan", "Livia", "Glacieli", "Isabela", "Pedro"}
  Local aNumero := {1,3,6,23,4,59,18,12}
  Local aTodos := {"Fernando",SToD("20250304"), 45, .T., {1,2,3}}

  //Como exibir uma array
  aNomes[4] // Glacieli
  aNumero[5] //4
  aTodos[1] //Fernando
  aTodos[5][3] // 3

  //Bloco de código
  Local bBloco := {|| nA := 1}
  Local nA := 0

  Eval(bBloco)

Return 
