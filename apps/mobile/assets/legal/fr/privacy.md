# Politique de confidentialité

**Version provisoire à valider.** Le responsable du traitement de MICHI est {{CONTROLLER}}, établi dans le pays suivant : {{COUNTRY}}. Demandes de confidentialité : [{{EMAIL}}](mailto:{{EMAIL}}).

## Ce qui reste sur ton appareil

- La base locale conserve tes parties en cours et terminées, tes progrès par technique, les grilles du jour terminées et les grilles importées.
- Les préférences locales couvrent le niveau initial, la fin de l’introduction, la langue, le rappel de série, les records personnels, les jours Spot it résolus, les tampons vus dans le carnet et ton choix sur les rapports de plantage.
- Avec ton autorisation, le scanner lit une prise de vue ou une photo sélectionnée. Un modèle TensorFlow Lite intégré la traite sur ton appareil. MICHI ne téléverse pas les photos et tente d’effacer la capture temporaire après lecture. L’original reste dans ta photothèque. Les versions internes de diagnostic peuvent conserver des fichiers de scan sur l’appareil.
- Si tu actives le rappel de série, il est programmé sur l’appareil selon les heures locales de fin de partie. Tu peux le désactiver dans les réglages ou retirer l’autorisation de notification.

## Compte et synchronisation

Sans compte, tes progrès restent sur l’appareil. Lors d’une inscription par e-mail, Firebase Authentication gère le nom, l’adresse, le mot de passe et l’identifiant du compte. Si ta version propose la connexion Google ou Apple et que tu l’utilises, ce fournisseur t’authentifie et Firebase reçoit les identifiants de connexion et les données disponibles du profil, comme le nom et l’adresse e-mail.

Une fois la connexion établie, Cloud Firestore synchronise les parties terminées, les défis du jour et les progrès par technique, avec des contributions par installation. Une partie importée terminée peut synchroniser les chiffres des grilles initiale et finale, les temps, les erreurs et les indices utilisés. Les parties en cours ne sont pas synchronisées. Les anciennes données du rappel de 8 h peuvent inclure l’identifiant d’installation, la plateforme, la langue, le fuseau horaire, le jeton de notification et les paramètres d’horaire.

## Services pour tout le monde

- Firebase Remote Config fournit des paramètres de contenu et de fonctionnalités. Firestore sert les grilles publiées et les défis du jour. Ces services reçoivent des données techniques courantes comme l’adresse IP et, selon le service, des informations sur le SDK ou l’installation.
- Le SDK Firebase Messaging est toujours inclus. Il peut créer des identifiants d’installation et d’inscription aux notifications push même si tu utilises uniquement le rappel local.
- Firebase App Check vérifie l’application et l’appareil avec Play Integrity ou App Attest, avec DeviceCheck en secours, pour limiter les abus.
- Firebase Crashlytics aide à diagnostiquer les plantages. Les rapports peuvent inclure la trace de pile, le modèle, le système, la version de l’app et des informations d’installation. **Partager les rapports de plantage** est activé par défaut dans les versions publiées. Tu peux le modifier dans Réglages → À propos de MICHI. La désactivation arrête les nouveaux rapports Dart. Le SDK natif peut appliquer ce changement au prochain lancement. Les rapports déjà envoyés restent inchangés et le SDK peut conserver localement des informations sur les plantages.

La collecte Firebase Analytics est désactivée. MICHI ne contient pas de publicité, ne te suit pas dans d’autres apps et ne vend pas tes données. MICHI ne collecte pas encore de données de paiement. Si MICHI Plus propose des achats, Apple ou Google les traitera selon ses conditions.

## Prestataires, conservation et droits

Google fournit les [services Firebase](https://firebase.google.com/support/privacy). Apple peut traiter les données d’attestation et de connexion facultative. Firebase peut traiter les données hors de ton pays. La fonction de nettoyage des comptes s’exécute dans europe-west1. Firebase Authentication traite les données du compte aux États-Unis. Cela ne détermine pas le lieu de tous les services. Si tu nous écris, nous utilisons ton adresse et ton message pour répondre.

Les données locales restent jusqu’à leur suppression dans l’app, l’effacement du stockage ou la désinstallation, selon les sauvegardes du système. Les données synchronisées restent jusqu’à la suppression du compte. La conservation Firebase varie selon le service. {{RETENTION}} {{LEGAL_BASIS_TRANSFERS}}

Selon la loi applicable, tu peux demander l’accès, la rectification, l’effacement, la limitation ou la portabilité, t’opposer au traitement ou porter plainte auprès d’une autorité. Écris à [{{EMAIL}}](mailto:{{EMAIL}}). Les permissions de caméra, de photos et de notifications se règlent sur l’appareil.

## Retours

Lors de l’envoi, MICHI enregistre la catégorie, le message, l’adresse facultative de réponse et, si tu les ajoutes, la version et le build de l’app, la plateforme, la version du système, le modèle, la langue et l’état de connexion. L’adresse sert uniquement à répondre. L’identifiant d’installation et, si la session est ouverte, celui du compte servent à limiter les abus. Si la session est ouverte, le message est enregistré avec l’identifiant du compte. Le responsable de MICHI peut recevoir le message par e-mail. Une fois la règle de conservation activée, la suppression dans Firestore est prévue après 24 mois. Les copies par e-mail suivent {{RETENTION}}. Les brouillons restent sur ton appareil jusqu’à leur envoi ou à l’effacement du stockage. Aucune photo du scanner n’est jointe.

## Supprimer ton compte

Connecte-toi et ouvre **Profil → Réglages → Compte → Supprimer le compte**. Firebase supprime le compte et déclenche l’effacement des parties, progrès et rappels associés dans le cloud. MICHI retire le profil local du compte de cet appareil. Les données hors compte et les copies sur d’autres appareils peuvent rester. Si tu ne peux pas utiliser l’app, écris à [{{EMAIL}}](mailto:{{EMAIL}}) depuis l’adresse de ton compte pour demander la suppression du compte MICHI et des données associées. N’envoie pas ton mot de passe. Nous pouvons vérifier que le compte t’appartient.
