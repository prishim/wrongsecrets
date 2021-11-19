##############################
# Secret manager challenge 1 #
##############################

resource "google_secret_manager_secret" "wrongsecret_1" {
  secret_id = "wrongsecret-1"
  replication {
    automatic = true
  }
}

# TODO: check if this works as intended. Whole cluster can access this stuff.
resource "google_secret_manager_secret_iam_member" "wrongsecret_1_member" {
  project   = google_secret_manager_secret.wrongsecret_1.project
  secret_id = google_secret_manager_secret.wrongsecret_1.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = google_service_account.wrongsecrets_cluster.id
}

resource "random_password" "password" {
  length           = 24
  special          = true
  override_special = "_%@"
}

resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret = google_secret_manager_secret.wrongsecret_1.id

  secret_data = random_password.password.result
}


###############################
# Secret manager challenge 2 #
###############################

resource "google_secret_manager_secret" "wrongsecret_2" {
  secret_id = "wrongsecret-2"
  replication {
    automatic = true
  }
}

# TODO: check if this works as intended
resource "google_secret_manager_secret_iam_member" "wrongsecret_2_member" {
  project   = google_secret_manager_secret.wrongsecret_2.project
  secret_id = google_secret_manager_secret.wrongsecret_2.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = google_service_account.wrongsecrets_cluster.id
}

###############################
# Secret manager challenge 3 #
###############################

# resource "google_secret_manager_secret" "wrongsecret_3" {
#   secret_id = "wrongsecret-3"
#   replication {
#     automatic = true
#   }
# }

# # TODO: absolutely misconfigure. Make IAM scope too broad - pod service account "accidentaly" has access
# resource "google_secret_manager_secret_iam_member" "wrongsecret_3_member" {
#   project   = google_secret_manager_secret.wrongsecret_3.project
#   secret_id = google_secret_manager_secret.wrongsecret_3.secret_id
#   role      = "roles/secretmanager.secretAccessor"
#   member    = "serviceAccount:gke-workload@${var.project}.iam.gserviceaccount.com"
# }
