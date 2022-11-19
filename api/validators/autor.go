package validators

type CreateAutor struct {
	PrimeiroNome   string `binding:"required" json:"primeiro_nome"`
	Sobrenome      string `binding:"required" json:"sobrenome"`
	Sobre          string `binding:"-" json:"sobre"`
	Imagem         string `binding:"-" json:"imagem"`
	DataNascimento string `binding:"-" json:"data_nascimento"`
}
