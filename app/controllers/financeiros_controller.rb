class FinanceirosController < ApplicationController
  before_action :authenticate_user!
  def index
    @vendas = [
      venda("2026-01-10", "VD-24011", "Loja Aurora", "Loja Física", "B2C", "Orgânico", "Acessórios", "Kit Cabo Premium", 2, 189.90, 10.00, "Pago"),
      venda("2026-01-10", "VD-24012", "Grupo Boreal", "Atacado", "B2B", "Indicação", "Eletrônicos", "Mouse Sem Fio", 50, 39.90, 5.00, "Pago"),
      venda("2026-01-11", "VD-24013", "Mercado Orion", "E-commerce", "B2C", "Anúncio", "Casa", "Luminária LED", 1, 129.00, 0.00, "Pendente"),
      venda("2026-01-11", "VD-24014", "Comercial Atlas", "E-commerce", "B2B", "Outbound", "Escritório", "Cadeira Ergonômica", 4, 899.00, 12.00, "Pago"),
      venda("2026-01-12", "VD-24015", "Cliente Nimbus", "Marketplace", "B2C", "Marketplace", "Moda", "Camiseta Básica", 3, 49.90, 0.00, "Cancelado"),
      venda("2026-01-12", "VD-24016", "Solis Distrib.", "Atacado", "B2B", "Indicação", "Acessórios", "Carregador 20W", 30, 59.90, 8.00, "Pago"),
      venda("2026-01-13", "VD-24017", "Cliente Delta", "Loja Física", "B2C", "Orgânico", "Escritório", "Caderno A5", 5, 19.90, 0.00, "Pago"),
      venda("2026-01-13", "VD-24018", "Prisma & Cia", "E-commerce", "B2B", "Anúncio", "Casa", "Organizador", 10, 34.90, 15.00, "Pago"),
      venda("2026-01-14", "VD-24019", "Cliente Horizonte", "E-commerce", "B2C", "Orgânico", "Eletrônicos", "Fone Bluetooth", 1, 199.90, 0.00, "Pendente"),
      venda("2026-01-14", "VD-24020", "Cedro Import", "Marketplace", "B2B", "Marketplace", "Eletrônicos", "Hub USB-C", 12, 79.90, 6.00, "Pago"),
      venda("2026-01-15", "VD-24021", "Cliente Lótus", "Loja Física", "B2C", "Indicação", "Moda", "Calça Jeans", 1, 159.90, 5.00, "Pago"),
      venda("2026-01-15", "VD-24022", "Safira Serviços", "Atacado", "B2B", "Outbound", "Casa", "Filtro de Linha", 25, 29.90, 10.00, "Pago"),
      venda("2026-01-16", "VD-24023", "Loja Aurora", "E-commerce", "B2C", "Anúncio", "Acessórios", "Bolsa Compacta", 8, 129.90, 7.50, "Pago"),
      venda("2026-01-16", "VD-24024", "Grupo Boreal", "Atacado", "B2B", "Indicação", "Eletrônicos", "Teclado Mecânico", 15, 249.00, 10.00, "Pago"),
      venda("2026-01-17", "VD-24025", "Mercado Orion", "Marketplace", "B2C", "Marketplace", "Casa", "Jogo de Panelas", 2, 329.90, 0.00, "Pendente"),
      venda("2026-01-17", "VD-24026", "Comercial Atlas", "E-commerce", "B2B", "Outbound", "Escritório", "Suporte Monitor", 6, 199.00, 5.00, "Pago"),
      venda("2026-01-18", "VD-24027", "Cliente Nimbus", "Loja Física", "B2C", "Orgânico", "Moda", "Tênis Casual", 1, 249.90, 15.00, "Pago"),
      venda("2026-01-18", "VD-24028", "Solis Distrib.", "Atacado", "B2B", "Indicação", "Acessórios", "Cabo HDMI", 100, 19.90, 0.00, "Pago"),
      venda("2026-01-19", "VD-24029", "Cliente Delta", "E-commerce", "B2C", "Anúncio", "Escritório", "Caneta Gel", 20, 4.90, 0.00, "Pago"),
      venda("2026-01-19", "VD-24030", "Prisma & Cia", "Marketplace", "B2B", "Marketplace", "Casa", "Toalha de Banho", 40, 24.90, 12.00, "Pago"),
      venda("2026-01-20", "VD-24031", "Cliente Horizonte", "E-commerce", "B2C", "Orgânico", "Eletrônicos", "Smartwatch", 3, 599.90, 0.00, "Pendente"),
      venda("2026-01-20", "VD-24032", "Cedro Import", "Atacado", "B2B", "Indicação", "Eletrônicos", "SSD 1TB", 8, 449.90, 8.00, "Pago"),
      venda("2026-01-21", "VD-24033", "Cliente Lótus", "Loja Física", "B2C", "Indicação", "Moda", "Jaqueta", 2, 349.90, 10.00, "Pago"),
      venda("2026-01-21", "VD-24034", "Safira Serviços", "E-commerce", "B2B", "Outbound", "Casa", "Aspirador Portátil", 5, 199.00, 5.00, "Pago"),
      venda("2026-01-22", "VD-24035", "Loja Aurora", "Marketplace", "B2C", "Marketplace", "Acessórios", "Relógio Minimal", 7, 189.00, 0.00, "Pago"),
      venda("2026-01-22", "VD-24036", "Grupo Boreal", "Atacado", "B2B", "Indicação", "Eletrônicos", "Roteador AC", 12, 329.90, 6.00, "Pago")
    ]

    # Filtros simples (por query/status/canal/classificacao)
    if params[:q].present?
      q = params[:q].downcase
      @vendas = @vendas.select do |v|
        [v[:pedido], v[:cliente], v[:produto], v[:categoria], v[:origem]].any? { |x| x.to_s.downcase.include?(q) }
      end
    end

    if params[:status].present?
      @vendas = @vendas.select { |v| v[:status] == params[:status] }
    end

    if params[:canal].present?
      @vendas = @vendas.select { |v| v[:canal] == params[:canal] }
    end

    if params[:classificacao].present?
      @vendas = @vendas.select { |v| v[:classificacao] == params[:classificacao] }
    end

    # KPIs para exibir no topo
    pagas = @vendas.select { |v| v[:status] == "Pago" }
    receita = pagas.sum { |v| v[:liquido] }
    qtd = pagas.sum { |v| v[:qtd] }
    ticket = pagas.any? ? (receita / pagas.size) : 0.0

    @kpis = {
      pedidos: @vendas.size,
      pagas: pagas.size,
      receita: receita,
      itens: qtd,
      ticket_medio: ticket
    }

    # Resumo por canal (opcional, mas dá “cara” de relatório)
    @por_canal = @vendas.group_by { |v| v[:canal] }.transform_values do |arr|
      pagas = arr.select { |v| v[:status] == "Pago" }
      pagas.sum { |v| v[:liquido] }
    end
  end

  private

  def venda(data, pedido, cliente, canal, classificacao, origem, categoria, produto, qtd, preco_unit, desconto_pct, status)
    bruto = (qtd * preco_unit).round(2)
    desconto = (bruto * (desconto_pct / 100.0)).round(2)
    liquido = (bruto - desconto).round(2)

    {
      data: Date.parse(data),
      pedido: pedido,
      cliente: cliente,
      canal: canal,                 # Loja Física | E-commerce | Atacado | Marketplace
      classificacao: classificacao, # B2B | B2C
      origem: origem,               # Orgânico | Anúncio | Indicação | Outbound | Marketplace
      categoria: categoria,         # Acessórios | Eletrônicos | Casa | Moda | Escritório...
      produto: produto,
      qtd: qtd,
      bruto: bruto,
      desconto: desconto,
      liquido: liquido,
      status: status                # Pago | Pendente | Cancelado
    }
  end
end
