abstract class TicketCategoryEvent {}

class FetchTicketCategory extends TicketCategoryEvent {
  final int fromStationId;
  final int toStationId;

  FetchTicketCategory({required this.fromStationId, required this.toStationId});
}