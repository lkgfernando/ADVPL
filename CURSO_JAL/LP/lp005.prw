#Include "Protheus.ch"

/*/{Protheus.doc} xCorrecao
(long_description)
@type user function
@author Fernando Rodrigues
@since 25/05/2025
@version version
@param param_name, param_type, param_descr
@return return_var, return_type, return_description
@example
(examples)
@see (links_or_references)
/*/
User Function xCorrecao()
  
  xNotas("João 0, Maria 1, Pedro 5, Beatriz 10, Ana 0")

Return

/*/{Protheus.doc} xNotas
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 25/05/2025
  @versio
  @param cLista
  @return , , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function xNotas(cLista)
  Local aLista := {}
  Local aNotas := {}
  Local nI     := 0
  Local nAt    := 0
  Default cLista := ""

  If !Empty(cLista)
    aLista := Separa(cLista, ",")

    For nI := 1 To Len(aLista)
      nAt := At(" ", AllTrim(aLista[nI])) 
      aAdd(aNotas, {Val(SubStr(aLista[nI],nAt+1)),SubStr(AllTrim(aLista[nI]),1,nAt -1)})
    Next nI

    aNotas := aSort(aNotas ,,, {|x,y| (x[1] < y[1]) .OR. ;
              (x[1] == y[1] .And. x[2] > y[2])})
    Alert("O aluno ou a aluna com a menor nota é : " + aNotas[1][2] + " com a nota " + cValToChar(aNotas[1][1]))
  else
    Alert("Lista vazia")
  EndIf

Return 
