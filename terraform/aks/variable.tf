variable "prefix" {
  type        = string
  description = "A prefix used for all resources in this example."
  default     = "myaks"
}

variable "rg"{
  type        = string
  description = "The name of the resource group where the AKS cluster will be created."
  default     = "XResourse-JP-1"
}

variable "acr" {
  type        = string
  description = "The name of the Azure Container Registry."
  default     = "jpacr"
}