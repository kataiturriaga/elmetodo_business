Edge cases the implementation must decide on

  1. Pause during ONBOARDING (no diet/routine yet, no iteration) → resume should go back to ONBOARDING / questionnaire, not to "iteration 2".
  2. Pause during REVIEW_SUBMITTED (user submitted, coach hadn't confirmed) → on resume, does the pre-pause review still count, or do we discard it? Boss's wording ("que le pida revisión") suggests discard and ask for a new one.
  3. Pause during FAKE_REVIEW_GRACE (fake review exists) → treat the fake as final, iteration += 1 on resume.
  4. Cancel vs pause — boss says "da igual si cancela o pausa". Treat identically in state-freeze logic; the distinction is only for billing/retention analytics.
  5. Multiple pause/resume cycles → each resume should increment iteration exactly once, not per calendar month elapsed.
  6. Automated users (is_automated=true) → Gold's Gym V1 users need the same freeze. Confirm with the boss whether "month 4 day 1 with new diet" is coach-mediated or self-paced for them.
  7. IAP auto-renewal resume → should this trigger the same resume flow, or only when the coach manually sets active? (Current disconnect between webhooks and User.subscription_status means nothing happens today.)
  8. V2 diet rotation — skipping iterations affects master_diet_id rotation pool exhaustion; fine in theory but worth a sanity check.
  9. Production backfill — users currently stuck in mid-catch-up need a one-off cleanup, otherwise their next interaction still triggers the old behavior.
  10. "Avanzar" debug utility (coach.py:1339-1378) — no longer meaningful for paused users; decide whether it should be disabled for them.
  11. Badge cleanup — if a paused user has unviewed late reviews (coach_viewed_at=NULL), the resume flow should mark them viewed so badges don't persist across the pause.
  12. program_start_date — iteration-date utilities key off this. Decide whether pause adjusts it (shifting the whole calendar) or leaves it alone (iteration counter diverges from wall-clock months, which is arguably what the boss
  wants).

  Want me to turn this into a full implementation plan (files to touch, order, migrations, tests), or do you want to go ask the boss about the edge cases (especially #2, #6, #7, #9) first?