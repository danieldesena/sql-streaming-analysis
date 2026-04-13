USE streaming;

-- Liste o nome de todos os usuários e os títulos dos filmes que eles avaliaram.
SELECT u.nome, f.titulo, a.nota
FROM usuarios u
JOIN avaliacoes a ON u.id_usuario = a.id_usuario_fk
JOIN filmes f ON a.id_filme_fk = f.id_filme
ORDER BY u.nome;


-- Mostre o título de cada filme e a nota dada. Exiba também o nome de quem avaliou.
SELECT f.titulo, u.nome, a.nota
FROM filmes f
JOIN avaliacoes a ON f.id_filme = a.id_filme_fk
JOIN usuarios u ON a.id_usuario_fk = u.id_usuario
ORDER BY f.titulo;


-- Quais filmes foram avaliados com nota 5?
SELECT f.titulo, u.nome
FROM filmes f
JOIN avaliacoes a ON f.id_filme = a.id_filme_fk
JOIN usuarios u ON a.id_usuario_fk = u.id_usuario
WHERE a.nota = 5;


-- Contar o número de avaliações feitas por cada usuário (incluindo usuários sem avaliações).
SELECT u.nome, COUNT(a.id_avaliacao) AS total_avaliacoes
FROM usuarios u
LEFT JOIN avaliacoes a ON u.id_usuario = a.id_usuario_fk
GROUP BY u.id_usuario, u.nome
ORDER BY total_avaliacoes DESC;


-- Qual a média de notas de cada filme?
SELECT f.titulo, ROUND(AVG(a.nota), 2) AS media_notas
FROM filmes f
JOIN avaliacoes a ON f.id_filme = a.id_filme_fk
GROUP BY f.id_filme, f.titulo
ORDER BY media_notas DESC;


-- Liste TODOS os filmes, mesmo os que ainda não receberam nenhuma avaliação.
SELECT f.titulo, f.genero, COUNT(a.id_avaliacao) AS total_avaliacoes
FROM filmes f
LEFT JOIN avaliacoes a ON f.id_filme = a.id_filme_fk
GROUP BY f.id_filme, f.titulo, f.genero;


-- Quais filmes NUNCA foram avaliados por nenhum usuário?
SELECT f.titulo, f.genero
FROM filmes f
LEFT JOIN avaliacoes a ON f.id_filme = a.id_filme_fk
WHERE a.id_avaliacao IS NULL;


-- Quais usuários do plano Premium já fizeram alguma avaliação?
SELECT u.nome, u.pais, f.titulo
FROM usuarios u
JOIN avaliacoes a ON u.id_usuario = a.id_usuario_fk
JOIN filmes f ON a.id_filme_fk = f.id_filme
WHERE u.plano = 'Premium';


-- Quais filmes foram avaliados por usuários do Brasil?
SELECT f.titulo, f.genero, COUNT(a.id_avaliacao) AS avaliacoes_brasil
FROM filmes f
JOIN avaliacoes a ON f.id_filme = a.id_filme_fk
JOIN usuarios u ON a.id_usuario_fk = u.id_usuario
WHERE u.pais = 'Brasil'
GROUP BY f.id_filme, f.titulo, f.genero
ORDER BY avaliacoes_brasil DESC;


-- Mostre os casos em que o usuário avaliou o filme sem tê-lo assistido por completo.
SELECT u.nome, f.titulo, a.nota
FROM avaliacoes a
JOIN usuarios u ON a.id_usuario_fk = u.id_usuario
JOIN filmes f ON a.id_filme_fk = f.id_filme
WHERE a.assistiu_completo = 0;