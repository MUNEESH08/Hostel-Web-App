terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 1.0"
    }
  }
}

provider "vercel" {
  api_token = var.vercel_api_token
}

# Create a Vercel project linked to your GitHub repo
resource "vercel_project" "terra_web_app" {
  name = "terra-web-app"

  git_repository = {
    type = "github"
    repo = "Muneesh08/Terra-Web-App"
    ref  = "main"
  }
}

# Trigger a deployment (for Docker-based project)
resource "vercel_deployment" "terra_web_app_deploy" {
  project_id = vercel_project.terra_web_app.id
  files = [
    {
      path = "Dockerfile"
      sha  = filemd5("${path.module}/../Dockerfile")
      data = file("${path.module}/../Dockerfile")
    }
  ]
  production = true
}

output "vercel_project_url" {
  value = "https://${vercel_project.terra_web_app.name}.vercel.app"
}
