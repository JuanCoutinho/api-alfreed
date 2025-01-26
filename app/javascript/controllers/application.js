import { Application } from "@hotwired/stimulus"
import Rails from "@rails/ujs"  // Importa Rails UJS para suportar 'method: :delete'

Rails.start() // Inicializa o Rails UJS

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
