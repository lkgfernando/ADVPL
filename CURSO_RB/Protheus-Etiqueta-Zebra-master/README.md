# Configurador Etiqueta Zebra :newspaper:

Voc� desenvolvedor Protheus j� precisou criar um modelo de etiqueta na m�o ?

Se sim, voc� sabe bem como � complicado trabalhar com as fun��es MSCB sem obter uma pr�via de como a etiqueta est� ficando, fora o tempo que voc� perde compilando um novo ajuste e fazendo a impress�o do modelo, rsrs. Afim de minimizar este trabalho desenvolvi este configurador, ou seja, atrav�s dele � poss�vel trazer as fun��es MSCB para uma interface ADVPL e conforme voc� vai parametrizando � gerado o c�digo nativo da impressora "ZPL", permitindo que um pr�-visualizador de terceiro "http://labelary.com/viewer.html" embutido no ERP se responsabilize com a renderiza��o da etiqueta.


![zebracfg.png](./resource/zebracfg.png)

O interessante que este configurador foi codificado utilizando o padr�o MVC e de fun��es\classes que podem ser utilizadas em seus projetos. Vejam s�.

* CRUD Advpl MVC + op��o de c�pia.
* Carga de um modelo de dados a partir de um arquivo JSON.
* Classes para gera��o de c�digo ZPL.
* Classe TWFHTML para manipula��o do HTML modelo.
* Classe FWFormContainer permite a divis�o de uma janela "MSDIALOG" usando o mesmo conceito de BOX (View MVC).
* Classe TBitmap para obter um visualizador do modelo finalizado.
* Classe FWButtonBar, para barra de bot�es personalizada.
* Aplica��o de CSS em um grid MVC.
* Manipula��o de diret�rios.
* Uso de macro-execu��o para blocos de c�digos.
* Uso de fun��o para realizar testes em portas, interface serial.

Aten��o: Este projeto foi desenvolvido na release 12.1.17 e melhorias s�o bem vindas.

# Como utilizar?

```
1. Compile os fontes que est�o no diret�rio /src 
2. Copie o diret�rio ./resource/zebra para dentro do seu RootPath.
3. Appenda as tabelas utilizadas no configurador. SX2, SX3, SIX, SXB e SX5 em DBF/CTREE ( ./resource/zebra/dbf/ ou /resource/zebra/ctree)
```

# Pr�ximas atualiza��es:

- [ ] Substitui��o do met�do de atualiza��o do WebPreview por webservice.
- [ ] Inclus�o de consulta padr�o com os modelos de impressora e par�metros MCSB.
- [ ] Adi��o de ret�ngulos ao Preview para referenciar imagens da etiqueta. 
- [ ] Inclus�o de novos modelos de etiqueta.
- [x] Substitui��o do componente TIBrowse pelo TwebEngine. (TIBrowse foi descontinuado nas releases superiores a 12.1.17)


## Tecnologias

Projeto desenvolvido em:

- [Advpl](https://tdn.totvs.com/display/public/PROT/AdvPl+utilizando+MVC)
- [HTML](https://pt.wikipedia.org/wiki/HTML)
- [Javascript](https://pt.wikipedia.org/wiki/JavaScript)

Framework 

- [MVC](https://tdn.totvs.com/display/public/PROT/AdvPl+utilizando+MVC)