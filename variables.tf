variable "app" {
    type = object({
        port = number
        internal_port = number
        container_port = number
        name = string
        cpu = number
        memory = number
        request_per_target = number
        minCount = number
        maxCount = number
    })
    default = {
        port = 80
        internal_port = 80
        container_port = 80
        name = "app"
        cpu = 256
        memory = 1024
        request_per_target = 10
        minCount = 1
        maxCount = 3
    }
}
