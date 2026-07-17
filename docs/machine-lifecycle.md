# Machine lifecycle

## Factory reset

A reset keeps the same logical role. The process is checkpointed:

1. Review recoverability before erasure.
2. Install the operating system and bootstrap prerequisites.
3. Create new machine identities rather than copying old private keys.
4. Clone the exact dual-remote source.
5. Run a read-only source preflight.
6. Apply managed files and approve package scopes separately.
7. Restore machine-local data from its owning systems.
8. Re-enroll services and run focused verification.
9. Resume automation only after the baseline checkpoint passes.

Each completed phase is recorded in a non-secret local checkpoint, so a failed
step can resume without repeating unrelated work.

## Hardware replacement

A replacement is staged on a candidate branch while the old machine remains
active. The candidate can change only the selected role's hardware binding.
It must complete bootstrap, local-state restoration, service enrollment, and
focused verification before the inventory commit can enter the signed cutover.

Source CI can pre-validate the candidate architecture with synthetic inventory
data before hardware is purchased or enrolled. That removes avoidable template
and policy surprises while leaving host keys, service identities, local data,
and the final role binding to the real candidate workflow.

The candidate is not a third production workstation. It is a temporary future
binding for one of the existing roles.

## Retirement

The old machine remains available until the replacement release has a valid
completion record. Retirement then requires separate confirmation that old
machine identities were revoked, service device entries were removed, and
non-secret evidence was archived. Erasure remains a deliberate physical action
and is never performed by repository automation.
