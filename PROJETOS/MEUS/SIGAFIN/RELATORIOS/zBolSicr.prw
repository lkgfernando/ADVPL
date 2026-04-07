#Include "Totvs.ch"


User Function zBolSicr()
    Local oPrinter
    Local cLinhaDig  := "74891.12344 56789.123456 78910.123456 1 80000000010000"
    Local cBarCode   := "74891800000000010000123456789123456789101234" // 44 dígitos numéricos
    Local cPixEMV    := "00020126580014br.gov.bcb.pix01366085a85c-1234-4a51-8b32-e00000000000" // Exemplo
    
    // Inicia a impressora (6 = PDF)
    oPrinter := FWMSPrinter():New("BOLETO_SICREDI", 6, .T.)
    oPrinter:SetPortrait()
    oPrinter:StartPage()

    // 1. LINHA DIGITÁVEL (Texto formatado)
    oPrinter:Say(750, 500, cLinhaDig, "Arial", 10, .T., .F., 1) // Alinhado à direita

    // 2. CÓDIGO DE BARRAS (Padrão Intercalado 2 de 5)
    // Sintaxe: SayBar(nRow, nCol, cCodigo, nTipo, nLargura, nAltura)
    // Tipo "25" é o padrão Febraban
    oPrinter:SayBar(800, 50, cBarCode, "25", 0.8, 50)

    // 3. QR CODE PIX (Lado a lado ou acima das instruções)
    // Posicionado acima do código de barras para dar destaque
    oPrinter:Say(700, 50, "PAGAMENTO VIA PIX (BOLETO HÍBRIDO)", "Arial", 08, .T.)
    oPrinter:QRCode(715, 50, cPixEMV, 60) // QR Code com 60px de tamanho

    oPrinter:EndPage()
    
    // Preview ou Impressão direta
    oPrinter:Print()
Return
