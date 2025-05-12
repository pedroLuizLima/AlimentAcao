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

## Arquitetura

Aqui você disserta sobre a arquitetura que você usou no projeto, que vai desde um desenho que represente a arquitetura usada, como o exemplo abaixo, até mesmo os padrões de projeto que você usou.

![Curto.io Example Architecture](./imgs/MER AlimentAção (2).png)

Exemplo de texto (explicando a arquitetura do curto.io):

**Next.js**

*Usei Next.js para o frontend devido sua tecnologia server-side, grande parte do projeto precisaria ser gerada no servidor e isso traria grandes vantagens para a aplicação como um todo. Isso, acrescido com a curva de aprendizado baixa por eu já fazer uso dela, me fez tomar a decisão de usá-lo nesse projeto*

**Redis**

*Devido sua característica de KVS (Key Value Store), funciona como uma luva para armazenar os tokens dos links curtos para que possamos posteriormente "trocar" por links longos na aplicação, garantindo rapidez e escala na hora de redirecionarmos os usuários, evitando com que a minha API principal seja bombardeada com tanto tráfego no redirecionamento.*

*Para o redis, estou utilizando Upstash, uma solução que provê o redis como uma plataforma serverless, que vai ser muito legal para o momento da minha aplicação, que vai escalar no decorrer do tempo, além de oferecer um preço muito bacana.*

**Spring Boot**

*É o backend principal da minha aplicação, feita em Kotlin somente pelo motivo de eu já conhecer a linguagem e ter experiência com o ecossistema Java, partir pra esse lado me deu muita produtivdade na hora de codificar os endpoints da API.*

*Apesar de existir a opção de usar as API routes do Next.js, e ser uma ótima opção devido ao incrível serverless da Vercel, para que a aplicação não fique tão cara 🤑 caso ela escale. Unir custo baixo e velocidade no desenvolvimento me deu muita força pra entregar esse projeto.*

## Features

Aqui você descreve as principais features do sistema, de preferência com foto do fluxo da feature ou uma descrição breve do que ela faz.

Exemplo (features do curto.io):

1. Criação de um link curto:

![Feature 1](./images/feature_1.png)

2. Redirecionamento de um link curto para um link longo:

![Feature 2](./images/feature_2.png)

## Instruções de execução

Aqui você descreve brevemente como fazer a instalação das dependências dos projetos, os pré-requisitos para se conseguir fazer isso e como executar a aplicação.

## Contribua com o projeto

Aqui você coloca instruções claras de como contribuir com o projeto, ou você pode colocar um direcionamento à outro arquivo que liste melhor a forma de como contribuir com o projeto.

Exemplo:
