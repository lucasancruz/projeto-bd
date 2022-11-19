package validators

type CreateEditora struct {
	Nome string `binding:"required" json:"nome"`
}
