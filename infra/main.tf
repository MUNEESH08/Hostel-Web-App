terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.7.0"
    }
  }
}

provider "vercel" {
  api_token = var.vercel_api_token
}

resource "vercel_project" "flask_app" {
  name = "flask-on-vercel"
}

resource "vercel_deployment" "flask_deploy" {
  project_id = vercel_project.flask_app.id

  files = {
    "Dockerfile"       = file("./Dockerfile")
    "app.py"           = file("./app.py")
    "requirements.txt" = file("./requirements.txt")
  }

  path_prefix = "/"
  production  = true
}
