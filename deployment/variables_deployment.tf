##############################
# Required Variables
##############################
variable "rest_api_id" {
  type        = string
  description = "ID da REST API"
}

variable "stage_name" {
  type        = string
  description = "Nome do stage da API"
}

variable "triggers_sha" {
  description = "Hash trigger para forçar novo deployment quando métodos mudam"
  type        = string
}

##############################
# Stage Configuration
##############################
variable "stage_variables" {
  type        = map(string)
  default     = {}
  description = "Variáveis do stage (key-value pairs)"
}

variable "stage_description" {
  type        = string
  default     = null
  description = "Descrição do stage"
}

##############################
# Throttling Settings
##############################
variable "throttle_settings" {
  type = object({
    rate_limit  = number
    burst_limit = number
  })
  default     = null
  description = "Configurações de throttling para o stage"
}

##############################
# Caching Settings
##############################
variable "cache_cluster_enabled" {
  type        = bool
  default     = false
  description = "Habilita cache cluster para o stage"
}

variable "cache_cluster_size" {
  type        = string
  default     = "0.5"
  description = "Tamanho do cache cluster (0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118, 237 GB)"
  
  validation {
    condition = contains([
      "0.5", "1.6", "6.1", "13.5", "28.4", "58.2", "118", "237"
    ], var.cache_cluster_size)
    error_message = "Cache cluster size deve ser um dos valores válidos: 0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118, 237."
  }
}

variable "cache_ttl_in_seconds" {
  type        = number
  default     = 300
  description = "TTL do cache em segundos"
}

variable "cache_data_encrypted" {
  type        = bool
  default     = false
  description = "Encrypta dados do cache"
}

variable "require_authorization_for_cache_control" {
  type        = bool
  default     = true
  description = "Requer autorização para controle de cache"
}

variable "unauthorized_cache_control_header_strategy" {
  type        = string
  default     = "SucceedWithResponseHeader"
  description = "Estratégia para headers de controle de cache não autorizados"
  
  validation {
    condition = contains([
      "FailWith403", "IgnoreWithWarning", "SucceedWithResponseHeader", "SucceedWithoutResponseHeader"
    ], var.unauthorized_cache_control_header_strategy)
    error_message = "Deve ser um dos valores: FailWith403, IgnoreWithWarning, SucceedWithResponseHeader, SucceedWithoutResponseHeader."
  }
}

##############################
# Logging Settings
##############################
variable "logging_level" {
  type        = string
  default     = null
  description = "Nível de logging (OFF, ERROR, INFO)"
  
  validation {
    condition = var.logging_level == null || contains(["OFF", "ERROR", "INFO"], var.logging_level)
    error_message = "Logging level deve ser OFF, ERROR ou INFO."
  }
}

variable "data_trace_enabled" {
  type        = bool
  default     = false
  description = "Habilita trace de dados nos logs"
}

variable "metrics_enabled" {
  type        = bool
  default     = true
  description = "Habilita métricas do CloudWatch"
}

variable "log_retention_in_days" {
  type        = number
  default     = 7
  description = "Retenção dos logs em dias"
}

variable "create_log_role" {
  type        = bool
  default     = true
  description = "Cria role IAM para logs do API Gateway"
}

##############################
# Custom Domain (opcional)
##############################
variable "domain_name" {
  type        = string
  default     = null
  description = "Nome do domínio customizado"
}

variable "certificate_arn" {
  type        = string
  default     = null
  description = "ARN do certificado SSL/TLS para o domínio"
}

variable "base_path" {
  type        = string
  default     = null
  description = "Caminho base para o mapeamento do domínio"
}

##############################
# Tags
##############################
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para os recursos"
}