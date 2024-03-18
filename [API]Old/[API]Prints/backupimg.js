const mysql = require('mysql2');
const axios = require('axios');
const fs = require('fs');
const path = require('path');

const db = mysql.createConnection({
  host: 'localhost', // Substitua pelo host do seu banco de dados MariaDB
  user: 'uw33dzinho', // Substitua pelo nome de usuário do banco de dados
  password: 'suasenha1711PT#', // Substitua pela senha do banco de dados
  database: 'anticheat', // Substitua pelo nome da sua base de dados
});
// Conecta ao banco de dados
db.connect(err => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados:', err);
    return;
  }

  const deleteAllQuery = 'DELETE FROM backup';
      db.query(deleteAllQuery, (err) => {
        if (err) {
          console.error('Erro ao remover registros da tabela backup:', err);
        } else {
          console.log('Registros da tabela backup removidos com sucesso.');
        }
      })

  // Consulta a tabela gbans para obter as URLs das imagens
  const selectQuery = 'SELECT id, img FROM gbans WHERE img IS NOT NULL';

  db.query(selectQuery, (err, results) => {
    if (err) {
      console.error('Erro ao consultar a tabela gbans:', err);
      //db.end(); // Encerre a conexão após a consulta
      return;
    }

    if (results.length === 0) {
      console.error('Nenhuma linha encontrada na tabela gbans.');
      //db.end(); // Encerre a conexão se não houver resultados
      return;
    }

    // Processa todas as linhas da tabela gbans
    results.forEach(row => {
      const id = row.id;
      const imgUrl = row.img;

      // Faz o download da imagem usando axios
      axios.get(imgUrl, { responseType: 'arraybuffer' })
        .then(response => {
          const binaryData = response.data;
          const sequencia = "https://images.uw33dac.me/";
          const partesDoLink = imgUrl.split('/');
          var valorFinal = partesDoLink[partesDoLink.length - 1];
          if (!imgUrl.startsWith(sequencia)) valorFinal =  Math.floor(Math.random() * 1000000) + 1
          // Insere o binário na tabela backup
          const insertQuery = 'INSERT INTO backup (nome, binario) VALUES (?,?)';
          db.query(insertQuery, [valorFinal, binaryData], (err) => {
            if (err) {
              console.error('Erro ao inserir binário na tabela backup');
            } else {
              console.log(`Binário da imagem da linha ${id} inserido na tabela backup com sucesso.`);
              salvarImagemLocalmente(valorFinal, binaryData);
//			//
			const update = `UPDATE gbans set img = ? where id = ?`
              db.query(update, [`${sequencia}${valorFinal}`, id], (err) => {
              	if (err) {
              		console.log("Erro ao atualizar IMG")
              	}
              })
//			//
            }
          });
        })
        .catch(err => {
          console.error(`Erro ao fazer o download da imagem da linha ${id}`);
        });
    });

    // Encerre a conexão após todas as operações no banco de dados
    //db.end();
  });
});

// Função para salvar a imagem localmente
function salvarImagemLocalmente(id, binaryData) {
  const pastaDestino = './uploads'; // Diretório onde as imagens serão salvas
  const nomeDoArquivo = `${id}.png`; // Nome do arquivo da imagem

  // Verifica se a pasta de destino existe, senão a cria
  if (!fs.existsSync(pastaDestino)) {
    fs.mkdirSync(pastaDestino);
  }

  // Caminho completo do arquivo de destino
  const caminhoDoArquivo = path.join(pastaDestino, nomeDoArquivo);

 	// Verifica se o arquivo já existe na pasta local
  if (fs.existsSync(caminhoDoArquivo)) {
    console.log(`Arquivo ${nomeDoArquivo} já existe na pasta local. Ignorando.`);
    return;
  }
  // Grava o binário no arquivo
  fs.writeFile(caminhoDoArquivo, binaryData, 'binary', err => {
    if (err) {
      console.error(`Erro ao salvar a imagem ${nomeDoArquivo} localmente:`, err);
    } else {
      //console.log(`Imagem ${nomeDoArquivo} salva localmente com sucesso.`);
    }
  });
}

//
function executarTarefa() {
  // Coloque o código que deseja executar diariamente aqui
  console.log('Tarefa diária executada.');

  // Agende a próxima execução em 24 horas (86400000 milissegundos)
  setTimeout(executarTarefa, 86400000);
}

// Inicie a primeira execução da tarefa
executarTarefa();
