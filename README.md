# PriceService - Cálculo de preços com descontos

Este projeto implementa um serviço de cálculo de preços para produtos, levando em consideração impostos e dois tipos de descontos: um para categorias específicas de produtos (como alimentos e bebidas) e outro aplicável no mês de aniversário do usuário. O serviço é acompanhado por testes que garantem a funcionalidade adequada em diversos cenários.

## Abordagem de Resolução

A solução foi projetada com foco em modularidade, clareza e extensibilidade. Abaixo estão os princípios e boas práticas adotadas:

### Boas práticas e design patterns utilizados

1. **Princípio da responsabilidade única (SRP)**:
   - Cada método possui uma única responsabilidade. A lógica de cálculo de preços, impostos e descontos foi separada em diferentes métodos para tornar o código mais claro e fácil de manter.

2. **Extração de constantes**:
   - Descontos como a taxa de 5% para categorias e 10% para aniversários foram extraídos para constantes, evitando valores mágicos no código e facilitando ajustes futuros.

3. **Uso de `fetch` para valores opcionais**:
   - O método `fetch` foi utilizado para valores opcionais no hash `product`, como o `tax_percentage`, garantindo um valor padrão (0) quando a chave está ausente e levantando erros quando valores obrigatórios, como `base_price`, estão faltando.

4. **Aplicação de descontos em sequência**:
   - O método `apply_discounts` foi criado para aplicar todos os descontos aplicáveis, mantendo a lógica de cálculo do preço final clara e separada das regras de desconto.

5. **Separação de lógica de elegibilidade**:
   - Métodos específicos para verificar se um produto é elegível para um desconto (como `eligible_for_category_discount?` e `eligible_for_birthday_discount?`) foram implementados, tornando o código mais claro e de fácil adaptação a futuras regras de negócio.

### Estrutura da Classe

A classe `PriceService` é composta pelos seguintes métodos principais:

- `#call`: Método principal que calcula o preço final, considerando impostos e aplicando descontos.
- `#calculate_final_price`: Calcula o preço final base com impostos.
- `#apply_discounts`: Aplica os descontos de categoria e aniversário, se aplicáveis.
- `#eligible_for_category_discount?`: Verifica se o produto pertence às categorias que recebem desconto.
- `#eligible_for_birthday_discount?`: Verifica se o usuário tem direito ao desconto de aniversário.

## Execução

### Pré-requisitos

- **Ruby**: Certifique-se de ter o Ruby instalado em sua máquina. A versão recomendada é a 3.3.4 ou superior.
- **RSpec**: Usado para testes automatizados. Instale-o usando o seguinte comando:

```bash
gem install rspec
```

### Como Executar

1. **Clonar o Repositório**:
   
   Clone este repositório para sua máquina local:
   
   ```bash
   git clone https://github.com/fabianoleittes/code-challenge-soutag.git
   cd code-challenge-soutag
   ```

2. **Executar os Testes**:
   
   O projeto usa o RSpec para testes. Para garantir que tudo está funcionando corretamente, execute os testes com o seguinte comando:

   ```bash
   bin/rspec
   ```

   Isso irá rodar todos os testes e garantir que o cálculo de preços e descontos está funcionando conforme esperado.

3. **Usar o Serviço de Preço**:

   Você pode instanciar o serviço `PriceService` para calcular preços de produtos:

   ```ruby
   product = { base_price: 100, tax_percentage: 10, category: 'food' }
   user = { birthday_month: Date.today.month }

   service = PriceService.new(product: product, user: user)
   final_price = service.call
   puts "Preço final: #{final_price}"
   ```

   O exemplo acima calcula o preço final de um produto da categoria `food`, aplicando impostos e descontos (se for o mês de aniversário do usuário).

### Exemplo de Uso

Se o produto for da categoria `food` e o imposto for de 10%, o preço final será calculado da seguinte forma:

1. Preço base: 100
2. Imposto (10%)
3. Desconto de categoria (5%)
4. Se for o mês de aniversário do usuário, um desconto adicional de 10% será aplicado sobre o total.

## Conclusão

Esta solução foi criada com foco em extensibilidade e fácil manutenção. O código está organizado para que seja simples adicionar novos descontos ou impostos no futuro, e os testes garantem que a lógica atual funciona conforme esperado.