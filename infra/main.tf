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

# Create the Vercel project
resource "vercel_project" "terra_web_app" {
  name      = "terra-web-app"
  framework = "other"   # Use "other" for Docker-based apps

  git_repository = {
    type = "github"
    repo = "Muneesh08/Terra-Web-App"
    ref  = "main"
  }

  # Enable automatic deployments from GitHub
  auto_assign_custom_domains = false
  ignore_command             = false
}

# Optionally, trigger a deployment after project creation
resource "vercel_deployment" "terra_web_app_deploy" {
  project_id = vercel_project.terra_web_app.id
  files {
    # Vercel automatically detects Dockerfile — you don’t need to list files individually
    path     = "./Dockerfile"
    sha      = filemd5("./Dockerfile")
    data     = file("./Dockerfile")
  }
  production = true
}

output "vercel_project_url" {
  value = "https://${vercel_project.terra_web_app.name}.vercel.app"
}
