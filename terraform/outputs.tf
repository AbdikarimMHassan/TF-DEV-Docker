output "pet_name" {
  description = "The randomly generated pet name"
  value       = random_pet.greeting.id
}

output "greeting_file" {
  description = "Path to the generated greeting file"
  value       = local_file.greeting.filename
}
