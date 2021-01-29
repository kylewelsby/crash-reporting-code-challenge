object false
node(:invalid) { |m| @project.invalid_count.value }
node(:error) { |m| @project.error_count.value }
node(:warning) { |m| @project.warning_count.value }
node(:info) { |m| @project.info_count.value }
