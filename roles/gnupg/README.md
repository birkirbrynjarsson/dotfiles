# gnupg role

This role restores my GnuPG config and keys from dotfiles.

## Files
- `gpg.conf`: GnuPG config
- `gpg-agent.conf`: agent config
- `public.asc`: exported public key
- `ownertrust.txt`: exported ownertrust
- `secret.asc.vault`: exported secret key encrypted with Ansible Vault

## Refreshing exported files

Run on the source machine:

```bash
gpg --armor --export you@example.com > roles/gnupg/files/public.asc
gpg --armor --export-secret-keys you@example.com > roles/gnupg/files/secret.asc
gpg --export-ownertrust > roles/gnupg/files/ownertrust.txt
ansible-vault encrypt roles/gnupg/files/secret.asc
mv roles/gnupg/files/secret.asc roles/gnupg/files/secret.asc.vault
cp ~/.gnupg/gpg.conf roles/gnupg/files/gpg.conf
cp ~/.gnupg/gpg-agent.conf roles/gnupg/files/gpg-agent.conf