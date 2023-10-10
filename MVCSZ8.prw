#INCLUDE 'PROTHEUS.ch'
#INCLUDE 'FWMVCDEF.ch'

User Function MVCSZ8()
Local aArea             := GetNextAlias()

// VARIAVEL QUE RECEBERA O INSTANCIALMENTO DA CLASSE FWMBROWSE
Local oBrowseSZ8                                
oBrowseSZ8              := FwmBrowse():New()

// PASSO COMO PARAMETRO A TABELA QUE IRA MOSTRAR NO BROWSE
oBrowseSZ8:SetAlias("SZ8")                      

oBrowseSZ8:SetDescription("Aluguel de Itens")

//  LEGENDA VERDER OU VERMELHO
oBrowseSZ8:AddLegend("SZ8 -> Z8_STATUS == '1'", "GREEN", "Cadastro Ativo")
oBrowseSZ8:AddLegend("SZ8 -> Z8_STATUS == '2'", "RED", "Cadastro Inativo")

oBrowseSZ8:Activate()

RestArea(aArea)

Return

Static Function MenuDef()
Local aRotina           := {}

ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MVCSZ8' OPERATION 2 ACCESS 0        // 1 - PESQUISAR, 2 - VISUALIZAR, 3 - INCLUIR, 4 - ALTERAR, 5 - EXCLUIR, 6 - OUTRAS OPÇÕES ,7 - COPIAR
ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MVCSZ8' OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MVCSZ8' OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MVCSZ8' OPERATION 5 ACCESS 0
// ADD OPTION aRotina TITLE 'Legenda'    ACTION 'u_SZ8Legend'    OPERATION 6 ACCESS 0


Return aRotina


Static Function ModelDEF()
Local oModel            := NIL

Local oStructSZ8        := FwFormStruct(1, 'SZ8') // TRAZ A ESTRUTURA DA SZ8 (TABELA CAMPOS, CARACTERISTICA PARA O MODOLE) POR ISSO 1 NO INICIO

oModel                  := MPFormModel():New("MVCSZ8M")

oModel:AddFields("FORMSZ8",/*OWNER*/,oStructSZ8)  // ATRIBUINDO FORMULARIO PARA O MODELO

oModel:SetPrimaryKey({"Z8_FILIAL", "Z8_COD"})     // DEFININDO CHAVE PRIMARIA PARA APLICAÇÃO

oModel:SetDescription("Modelo de Dados do Cadastro de Aluguel")
        
oModel:GetModel("FORMSZ8"):SetDescription("Formulario de Cadastro de Aluguel")

Return oModel

Static Function ViewDef()

Local oView             := NIL

Local oModel            := FwLoadModel("MVCSZ8")

Local oStructSZ8        := FwFormStruct(2, 'SZ8')           // TRAZ A ESTRUTURA DA SZ8 (1 - MODEL | 2 - VIEW)
oView                   := FwFormView():New()               // CONSTRUINDO A PARTE DE VISÃO DOS DADOS

oView:SetModel(oModel)                                      // PASSAR O MODELO PARA A VIEW

oView:AddField("VIEWSZ8", oStructSZ8, "FORMSZ8")            // ATRIBUIÇÃO DA ESTRUTURA DE DADOS A CAMADA DE VISÃO

oView:CreateHorizontalBox("TELASZ8", 100)              
oView:EnableTitleView("VIEWSZ8", "Dados dos Cadastros")     // ADICIONANDO TITULO AO FORMULARIO

oView:SetCloseOnOk({||.T.})                                 // FORÇA O FECHAMENTO DA JANELA PASSANDO .T.

oView:SetOwnerView("VIEWSZ8", "TELASZ8")                    // 

Return oView

// Static Function SZ8Legend()
// Local aLegenda          := {}
// aAdd(aLegenda, {"BR_VERDE", "Ativo"})
// aAdd(aLegenda, {"BR_VERMELHO", "Inativo"})

// FWFORMBROWSE("Cadastros", "Ativos/Inativos", aLegenda)


// Return aLegenda

