# At most `limit` of something running at once across all web processes,
# counted in the shared cache (Solid Cache in production). Used for work that
# holds a Puma thread while waiting on another service. A count is kept for a
# few minutes at most, so a crashed request can't hold a place forever.
# A cache that can't count (the test environment's null store) sets no limit.
class ConcurrencyLimit
  HOLD_AT_MOST = 3.minutes

  # Runs the block and returns true, or returns false without running it when
  # any of the limits ({ cache_key => limit }) is already reached.
  def self.within(limits, &block)
    key, limit = limits.first
    return block.call || true if key.nil?

    count = Rails.cache.increment(key, 1, expires_in: HOLD_AT_MOST)
    return within(limits.drop(1).to_h, &block) if count.nil?

    begin
      return false if count > limit

      within(limits.drop(1).to_h, &block)
    ensure
      Rails.cache.decrement(key, 1, expires_in: HOLD_AT_MOST)
    end
  end
end
