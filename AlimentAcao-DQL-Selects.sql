 use alimentacao;

SELECT doa.CPF "CPF", doa.nome "Doador", doa.telefone "Telefone",
	endd.cidade "Cidade"
	FROM doador doa
		INNER JOIN enderecodoador endd ON doa.CPF = endd.Doador_CPF
			WHERE endd.uf LIKE "PE";
            
SELECT doa.nome "Doador", doa.telefone "Telefone", count(doaa.idDoacaoAnonima) "Total de doações realizadas",
	concat(sum(doaa.pesoTotal_kg), " KG") "Peso total doado"
	FROM doador doa
		INNER JOIN doacaoanonima doaa ON doa.CPF = doaa.Doador_CPF
			GROUP BY doa.CPF
				ORDER BY sum(doaa.pesoTotal_kg) DESC;
                
SELECT ong.nomeInstituicao "Instituição", count(doae.idDoacaoEspecifica) "Total de doações recebidas",
	concat(sum(doae.pesototal_kg), " KG") "Peso total recebido"
	FROM ONGInstituicaoIgreja ong
		LEFT JOIN doacaoEspecifica doae ON doae.ONGInstituicaoIgreja_CNPJ = ong.CNPJ
			GROUP BY ong.CNPJ
				ORDER BY ong.nomeInstituicao;
        
SELECT date_format(dataDoacao, '%m/%Y') "Mês", count(idDoacaoEspecifica) "Total de doações",
 concat(SUM(pesoTotal_kg), " KG") "Peso total recebido"
	FROM doacaoEspecifica
		WHERE onginstituicaoigreja_CNPJ = '12.345.678/0001-90'
			GROUP BY date_format(dataDoacao, '%m/%Y')
			