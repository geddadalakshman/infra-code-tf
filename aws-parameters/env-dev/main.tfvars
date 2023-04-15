parameters = [
  { name = "dev.frontend.catalogue_url", type = "String", value = "http://catalogue-dev.devops71.tech:8080/" },
  { name = "dev.frontend.user_url", type = "String", value = "http://user-dev.devops71.tech:8080/" },
  { name = "dev.frontend.cart_url", type = "String", value = "http://cart-dev.devops71.tech:8080/" },
  { name = "dev.frontend.shipping_url", type = "String", value = "http://shipping-dev.devops71.tech:8080/" },
  { name = "dev.frontend.payment_url", type = "String", value = "http://payment-dev.devops71.tech:8080/" },
  { name = "dev.cart.redis_host", type = "String", value = "redis-dev.devops71.tech" },
  { name = "dev.cart.catalogue_host", type = "String", value = "catalogue-dev.devops71.tech" },
  { name = "dev.cart.catalogue_port", type = "String", value = "8080" },
  { name = "dev.catalogue.mongo", type = "String", value = "true" },
  { name = "dev.catalogue.mongo_url", type = "String", value = "mongodb://mongodb-dev.devops71.tech:27017/catalogue" },
  { name = "dev.payment.cart_host", type = "String", value = "cart-dev.devops71.tech" },
  { name = "dev.payment.cart_port", type = "String", value = "8080" },
  { name = "dev.payment.user_host", type = "String", value = "user-dev.devops71.tech" },
  { name = "dev.payment.user_port", type = "String", value = "8080" },
  { name = "dev.payment.amqp_host", type = "String", value = "rabbitmq-dev.devops71.tech" },
  { name = "dev.shipping.cart_endpoint", type = "String", value = "cart-dev.devops71.tech:8080" },
  { name = "dev.shipping.db_host", type = "String", value = "mysql-dev.devops71.tech" },
  { name = "dev.user.mongo", type = "String", value = "true" },
  { name = "dev.user.redis_host", type = "String", value = "redis-dev.devops71.tech" },
  { name = "dev.user.mongo_url", type = "String", value = "mongodb://mongodb-dev.devops71.tech:27017/users" }
]

secrets = [
  { name = "dev.mysql.password", type = "SecureString", value = "RoboShop@1" },
  { name = "dev.rabbitmq.amqp_user", type = "SecureString", value = "roboshop" },
  { name = "dev.rabbitmq.amqp_pass", type = "SecureString", value = "roboshop123" },
  { name = "dev.payment.amqp_user", type = "SecureString", value = "roboshop" },
  { name = "dev.payment.amqp_pass", type = "SecureString", value = "roboshop123" }
]