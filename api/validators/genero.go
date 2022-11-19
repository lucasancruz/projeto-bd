package validators

type CreateGenero struct {
	Nome string `binding:"required" json:"nome"`
}
