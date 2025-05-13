# AlimentaAção

O AlimentAção é uma plataforma web que visa conectar potenciais doadores de alimento à instituições que necessitam dessas doações para realizar ações solidárias. 

## Introdução
Este documeonto tem por objetivo reunir os principais documentos produzidos referentes ao banco de dados da aplicação. O intuito disso é proporcionar transparência e organização quanto ao que acreditamos ser a maneira mais adequada de contextualizar, diagramar e modelar os dados associados à problemática na qual o projeto AlimentaAção, bem como o produto de software a ele vinculado, está inserido.

## Documentos criados

### MER
O Modelo Entidade-Relacionamento (MER) é uma abordagem conceitual usada no projeto de banco de dados para representar entidades, seus atributos e relacionamentos. Isso permite visualizar como os dados estão organizados e como as entidades se relacionam no sistema de informações. O MER é a base conceitual sobre a qual os Diagramas Entidade-Relacionamento (DER) são criados para representar graficamente essa estrutura.
#### Entidades:
- doador
- enderecoDoador
- redesSociaisDoador
- doacaoAnonima
- doacaoEspecifica
- doacaoAlimento
- alimentos
- ong/instituicao/igreja
- enderecoRecebedor
- redesSociaisRecebedor
- areaAtuacao
- alimentosAceitos

#### Descrição das entidades:
- doador (cpf, nome, telefone, email)
- enderecoDoador (cep, uf, cidade, bairro, rua, numero, complemento, doador_cpf)
- redesSociaisDoador (redeSocial, username, email, doador_cpf)
- doacaoAnonima (idDoacaoAnonima, dataDoacao, pesoTotal(kg), condicaoDeRetirada)
- doacaoEspecifica (idDoacaoEspecifica, dataDoacao, pesoTotal(kg), condicaoDeRetirada, metodoDeEntrega, doador_cpf, ong/instituicao/igreja_cnpj)
- doacaoAlimento (kilosAlimento, quantidade(und), alimentos_idAlimento, doacaoAnonima_idDoacaoAnonima, doacaoEspecifica_idDoacaoEspecifica)
- alimentos (idAlimento, nome, categoria)
- ong/instituicao/igreja (cnpj, nomeInstituicao, nomeResponsavel, tipoInstituicao, telefone, email, numBeneficiarios, horaDeAbertura, horaDeFechamento)
- enderecoRecebedor (cep, uf, cidade, bairro, rua, numero, complemento, ong/instituicao/igreja_cnpj)
- redesSociaisRecebedor(redeSocial, username, email, ong/instituicao/igreja_cnpj)
- areaAtuacao (bairro, ong/instituicao/igreja_cnpj)
- alimentosAceitos (tipoDeAlimento, ong/instituicao/igreja_cnpj)

#### Relacionamentos
- Doador tem EnderecoDoador
  - Doador possui apenas um EnderecoDoador, e um EnderecoDoador é de apenas um Doador
  - Cardinalidade: (1:1)
- Doador possui RedeSociaisDoador
  - Doador possui zero ou várias RedesSociaisDoador, e RedesSociaisDoador tem apenas um Doador
  - Cardinalidade: (1:n)
- Doador faz DoacaoAnonima
  - Doador faz zero ou várias DoacaoAnonima, e DoacaoAnonima é feita por apenas um doador
  - Cardinalidade: (1:n)
- Doador faz DoacaoEspecifica
  - Doador faz zero ou várias DoacaoEspecifica, e DoacaoEspecifia é feita por apenas um doador
  - Cardinalidade: (1:n)
- DoacaoAnonima possui DoacaoAlimento
  - DoacaoAnonima possui uma ou várias DoacaoAlimento, e DoacaoAlimento participar de nenhuma ou uma DoacaoAnonima
  - Cardinalidade (1:n)
- DoacaoEspecifica possui DoacaoAlimento
  - DoacaoEspecifica possui uma ou várias DoacaoAlimento, e DoacaoAlimento participar de nenhuma ou uma DoacaoEspecifica
  - Cardinalidade (1:n)
- DoacaoAlimento possui Alimentos
  - DoacaoAlimento possui apenas um Alimentos, e Alimentos participam de uma ou várias doacaoAlimento
  - Cardinalidade (1:n)
- DoacaoEspecifica possui ONG/Instituicao/Igreja
  - DoacaoEspecifica possui apenas uma ONG/Instituicao/Igreja, e ONG/Instituicao/Igreja recebe nenhuma ou várias DoacaoEspecifica
  - Cardinalidade (1:n)
- ONG/Instituicao/Igreja tem EnderecoRecebedor
  - ONG/Instituicao/Igreja possui apenas um EnderecoRecebedor, e um EnderecoRecebedor é de apenas um ONG/Instituicao/Igreja
  - Cardinalidade: (1:1)
- ONG/Instituicao/Igreja possui RedeSociaisRecebedor
  - ONG/Instituicao/Igreja possui zero ou várias RedeSociaisRecebedor, e RedeSociaisRecebedor tem apenas um ONG/Instituicao/Igreja
  - Cardinalidade: (1:n)
- ONG/Instituicao/Igreja possui uma AreaAtuacao
  - ONG/Instituicao/Igreja possui uma ou várias AreaAtuacao, e AreaAtuacao é de apenas uma ONG/Instituicao/Igreja
  - Cardinalidade: (1:n)
- ONG/Instituicao/Igreja possui alimentosAceitos
  - ONG/Instituicao/Igreja possui um ou vários alimentosAceitos, e alimentosAceitos são aceitos por apenas uma ONG/Instituicao/Igreja
  - Cardinalidade: (1:n)

### DER
O Diagrama Entidade-Relacionamento (DER) é uma representação gráfica amplamente utilizada no projeto de bancos de dados. Ele descreve as entidades (objetos), seus atributos (características) e os relacionamentos entre as entidades. Os retângulos representam as entidades, as elipses indicam os atributos e as linhas conectam as entidades para mostrar como elas se relacionam. O DER é uma ferramenta fundamental para visualizar e planejar a estrutura de um banco de dados antes da implementação, ajudando a definir como os dados são armazenados e acessados.
![MER do Projeto](./imgs/mer-alimentacao.jpg)

### DLD
O Diagrama Lógico de Dados (DLD) é uma representação gráfica que ilustra a estrutura lógica de um banco de dados. Nesse diagrama, são exibidas informações cruciais, como os tipos de atributos associados a cada entidade, bem como as chaves estrangeiras e restrições, como a chave única (unique key). Seu propósito fundamental é fornecer uma representação estruturada e específica da maneira como o banco de dados deve ser implementado. Em resumo, o DLD funciona como uma representação visual que orienta a implementação efetiva do banco de dados.
![MER do Projeto](./imgs/AlimentAcao.png)

### Dicionário de dados

#### Doador
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|CPF|Chave Primária, Obrigatório| Varchar|14|CPF do doador|
|Nome|Obrigatório|Varchar|200|Nome do doador|
|Telefone|Obrigatório|Varchar|14|Telefone do doador|
|Email|Chave exclusiva, Obrigatório|Varchar|100|Email do doador|

#### EnderecoDoador
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|CEP|Obrigatório|Varchar|9|CEP da rua do endereco do Doador|
|UF|Obrigatório|Varchar|2|Unidade Federativa do endereco do Doador|
|Cidade|Obrigatório|Varchar|45|Cidade do endereco do Doador|
|Bairro|Obrigatório|Varchar|45|Bairro do endereco do Doador|
|Rua|Obrigatório|Varchar|100|Rua do endereco do Doador|
|Numero|Obrigatório|INT||Número da residência do Doador|
|Complemento||Varchar|45|Complemento do endereco do Doador|
|Doador_CPF|Chave Primária, Chave estrangeira, Obrigatório|Varchar|14|CPF do Doador dono do endereco|

#### RedesSociaisDoador
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|RedeSocial|Obrigatório|Varchar|45|Rede Social|
|Username|Chave exclusiva, Obrigatório|Varchar|45|Perfil do Doador na Rede Social|
|Email|Obrigatório|Varchar|100|Email do Perfil da Rede Social|
|Doador_CPF|Chave estrangeira, Obrigatório|Varchar|14|CPF do Doador|

#### DoacaoAnonima
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|IdDoacaoAnonima|Chave Primária, Obrigatório|INT||Id das doações anônimas|
|DataDoacao|Obrigatório|Date||Data que foi feita a doação|
|PesoTotal(kg)|Obrigatório|INT|5|Peso total da doação anônima em quilos|
|CondiçãoDeRetirada|Obrigatório|Varchar|45|Registro de especificação do transporte do alimento (congelado, resfriado, enpacotado ou próximo ao vencimento)|
|Doador_CPF|Chave estrangeira, Obrigatório|Varchar|14|CPF do doador que fez a doação|

#### DoacaoEspecifica
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|IdDoacaoEspecifica|Chave Primária, Obrigatório|INT||Id das doações anônimas|
|DataDoacao|Obrigatório|Date||Data que foi feita a doação|
|PesoTotal(kg)|Obrigatório|INT|5|Peso total da doação anônima em quilos|
|CondiçãoDeRetirada|Obrigatório|Varchar|45|Registro de especificação do transporte do alimento (congelado, resfriado, enpacotado ou próximo ao vencimento)|
|MetodoDeEnrega|Obrigatório|Varchar|45|Registro se a entrega será feita pelo doador ou se ele necessita de apoio logístico|
|Doador_CPF|Chave estrangeira, Obrigatório|Varchar|14|CPF do doador que fez a doação|
|ONG/Instituicao/Igreja_CNPJ|Chave estrangeira, Obrigatório|Varchar|18|CNPJ da instituição que receberá a doação|

#### DoacaoAlimento
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|KilosAlimento(kg)|Obrigatório|INT|5|Quantidade de alimento doado em quilos|
|Quantidade(und)|Obrigatório|INT|5|Unidades de alimento doado|
|Alimentos_idAlimento|Chave estrangeira, Obrigatório|INT||Id do alimento doado|
|DoacaoEspecifica_idDoacaoEspecifica|Chave estrangeira|INT||Id da doação que o alimento participou|
|DoacaoAnonima_idDoacaoAnonima|Chave estrangeira|INT||Id da doação que o alimento participou|

#### Alimentos
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|IdAlimento|Chave primária, Obrigatório|INT||Id dos alimentos registrados|
|Nome|Obrigatório|Varchar|45|Nome do alimento|
|Categoria|Obrigatório|Varchar|45|Categoria que o alimento pertence|

#### ONG/Instituicao/Igreja
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|CNPJ|Chave primária, Obrigatório|Varchar|18|CNPJ da instituição que vai receber a doação|
|NomeInstituicao|Obrigatório|Varchar|100|Nome da instituição recebedora|
|NomeResponsável|Obrigatório|Varchar|100|Nome do responsável pela instituição recebedora|
|TipoInstituição|Obrigatório|Varchar|45|Registro de que tipo de instituição a instituição recebedora pertence|
|Telefone|Obrigatório|Varchar|14|Telefone da instituição recebedora|
|Email|Obrigatório|Varchar|100|Email da instituição recebedora|
|NumBeneficiarios|Obrigatório|INT|5|Número de beneficiários que a instituição atende|
|HoraDeAbertura|Obrigatório|Time||Horário de início do funcionamento da instituição recebedora|
|HoraDeFechamento|Obrigatório|Time||Horário de fim do funcionamento da instituição recebedora|

#### EnderecoRecebedor
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|CEP|Obrigatório|Varchar|9|CEP da rua do endereco da instituição recebedora|
|UF|Obrigatório|Varchar|2|Unidade Federativa do endereço da instituição recebedora|
|Cidade|Obrigatório|Varchar|45|Cidade do endereco da instituição recebedora|
|Bairro|Obrigatório|Varchar|45|Bairro do endereco da instituição recebedora|
|Rua|Obrigatório|Varchar|100|Rua do endereco da instituição recebedora|
|Numero|Obrigatório|INT||Número da residência da instituição recebedora|
|Complemento||Varchar|45|Complemento do endereco da instituição recebedora|
|ONG/Instituição/Igreja_CNPJ|Chave Primária, Chave estrangeira, Obrigatório|Varchar|18|CNPJ da instituição recebedora dona do endereco|

#### RedesSociaisRecebedor
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|RedeSocial|Obrigatório|Varchar|45|Rede Social|
|Username|Chave exclusiva, Obrigatório|Varchar|45|Perfil da instituição recebedora na Rede Social|
|Email|Obrigatório|Varchar|100|Email do Perfil da Rede Social|
|ONG/Instituição/Igreja_CNPJ|Chave estrangeira, Obrigatório|Varchar|14|CNPJ da instituição recebedora|

#### AreaAtuação
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|Bairro|Obrigatório|Varchar|45|Bairro que a instituição atua|
|ONG/Instituição/Igreja_CNPJ|Chave estrangeira, Obrigatório|Varchar|18|CNPJ da instituição recebedora|

#### AlimentosAceitos
|Atributo|Propriedades do Atributo|Tipo de Dado|Tamanho|Descrição|
|--------|------------------------|------------|-------|---------|
|TipoDeAlimento|Obrigatório|Varchar|45|Registro de tipos de alimento (congelado, resfriado, enpacotado ou próximo ao vencimento) que a instituição recebe|
|ONG/Instituição/Igreja_CNPJ|Chave estrangeira, Obrigatório|Varchar|18|CNPJ da instituição recebedora|
