output "managed_image_id" {
  description = "The ID of the created managed image"
  value       = azurerm_image.image.id
}
