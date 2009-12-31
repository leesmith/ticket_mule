require 'prawn/format'
require 'prawn/layout'

#Prawn.debug = true

#pdf.header pdf.margin_box.top_left do
#  pdf.font "Helvetica" do
#    pdf.text "This is the header", :size => 10, :align => :right
#    pdf.stroke_horizontal_rule
#  end
#end

pdf.footer [pdf.margin_box.left, pdf.margin_box.bottom + 10] do
  pdf.stroke_horizontal_rule
  pdf.text "<br/>Ticket ##{@ticket.id} - TicketMule", :size => 9, :align => :right
end

pdf.bounding_box([pdf.bounds.left, pdf.bounds.top],:width  => pdf.bounds.width, :height => pdf.bounds.height - 50) do
  pdf.text "<b>Ticket ##{@ticket.id}</b>", :size => 16
  pdf.move_down(16)

  pdf.font_size(11) do
    pdf.text "<b>Title:</b> #{@ticket.title}"
    pdf.move_down(2)

    data = [["<b>Contact:</b> #{@ticket.contact.full_name}", @ticket.closed? ? "<b>Closed at:</b> #{nice_date @ticket.closed_at}" : ""],
            ["<b>Created at:</b> #{nice_date @ticket.created_at}", "<b>Created by:</b> #{@ticket.creator.username}"],
            ["<b>Priority:</b> #{@ticket.priority.name}","<b>Group:</b> #{@ticket.group.name}"],
            ["<b>Status:</b> #{@ticket.status.name}","<b>Owner:</b> #{@ticket.owner.nil? ? 'Unassigned' : @ticket.owner.username}"]]

    pdf.table data, :border_width => 0,
                    :font_size => 11,
                    :column_widths => { 0 => 270, 1 => 270 },
                    :position => :left,
                    :horizontal_padding => 0

    pdf.move_down(5)

    pdf.text "<b>Details:</b>"
    pdf.text "#{@ticket.details}"

    unless @ticket.attachments.empty?
      pdf.move_down(10)
      pdf.text "<b>Attachments:</b>"
      @ticket.attachments.each_with_index do |a, i|
        pdf.text "#{i+1}. #{a.name} #{a.nice_file_size}"
      end
    end
  end
end

#pdf.font_size(9) do
#  pdf.number_pages "Page <page> of <total>", [pdf.bounds.right - 50, 0]
#end
