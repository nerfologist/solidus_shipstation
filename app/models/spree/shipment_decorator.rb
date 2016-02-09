Spree::Shipment.class_eval do
  # TODO: research Spree::Shipment states and determine if this what we need
  #   with inventory tracking turned on/off
  scope :exportable, -> { joins(:order).where('spree_shipments.state != ?', 'pending') }

  # TODO: research Shipstation docs and Spree::Shipment and determine if this is
  #   the right logic for determining what should be pulled
  def self.between(from, to)
    joins(:order).where(
      '(spree_shipments.updated_at > ? AND spree_shipments.updated_at < ?) OR
      (spree_orders.updated_at > ? AND spree_orders.updated_at < ?)',
      from, to, from, to
    )
  end
end
