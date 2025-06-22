#Include "Protheus.ch"

/*/{Protheus.doc} xImpRend
Em um pa�s imagin�rio denominado Lisarb, todos os habitantes ficam felizes em pagar seus impostos,
 pois sabem que nele n�o existem pol�ticos corruptos e os recursos arrecadados s�o utilizados em benef�cio da popula��o,
 sem qualquer desvio. A moeda deste pa�s � o Rombus, cujo s�mbolo � o R$.

Leia um valor com duas casas decimais, equivalente ao sal�rio de uma pessoa de Lisarb. Em seguida, 
calcule e mostre o valor que esta pessoa deve pagar de Imposto de Renda, segundo a tabela abaixo.

Lembre que, se o sal�rio for R$ 3002.00, a taxa que incide � de 8% apenas sobre R$ 1000.00,
pois a faixa de sal�rio que fica de R$ 0.00 at� R$ 2000.00 � isenta de Imposto de Renda. 
No exemplo fornecido (abaixo), a taxa � de 8% sobre R$ 1000.00 + 18% sobre R$ 2.00, o que resulta em R$ 80.36 no total. 
O valor deve ser impresso com duas casas decimais.

Entrada
A entrada cont�m apenas um valor de ponto flutuante, com duas casas decimais.

Sa�da
Imprima o texto "R$" seguido de um espa�o e do valor total devido de Imposto de Renda, 
com duas casas ap�s o ponto. Se o valor de entrada for menor ou igual a 2000, dever� ser impressa a mensagem "Isento".
/*/
User Function xImpRend()
  Local aResp := {}
  Local aPergs := {}
  Local nSalario := 0
  Local nImposto := 0
  Local cRet := ""

  aAdd(aPergs,{1,"Digite o valor do s�lario: ", nSalario,"999999","","","",20,.T.})

  If ParamBox(aPergs, "Calculando imposto de renda....", aResp)
    Do Case
      case aResp[1] > 0 .And. aResp[1] <= 2000
        cRet := "Isento"

      case aResp[1] > 2000 .And. aResp[1] <= 3000
        nImposto := aResp[1] * 0.08 

      case aResp[1] > 3000 .And. aResp[1] <= 4500
        nImposto := aResp[1] * 0.18

      Otherwise
        nImposto := aResp[1] * 0.28
    EndCase
  EndIf

  Alert("Imposto de renda a pagar: R$ " + IIF(cRet == "",cValToChar(nImposto), cRet))
  

Return 
