import 'package:delivery/global/styles.dart';
import 'package:delivery/models/productos.dart';
import 'package:delivery/views/extras/ver_producto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductoGeneral extends StatelessWidget {
  final Producto producto;

  const ProductoGeneral({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: const Color(0xffF3F5F6),
    builder: (builder) {
      return const VerProductoView();
    });
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: Styles.containerCustom(),
            child: Row(
              children: [
                Container(
                  decoration: Styles.containerCustom(8),
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const Image(
                      image: NetworkImage(
                          'https://saboryestilo.com.mx/wp-content/uploads/2019/09/platillos-tipicos-de-mexico1-1200x675.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 92,
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(producto.nombre,
                            style: Styles.letterCustom(20, true, 1)),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.place_outlined,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                const SizedBox(width: 5),
                                Text('Nombre del lugar que envia',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 13, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  color: Colors.grey,
                                  size: 13,
                                ),
                                const SizedBox(width: 5),
                                Text('15 min',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 13, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating: 4.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const FaIcon(
                                FontAwesomeIcons.solidStar,
                                color:  Color.fromRGBO(62, 204, 191, 1),
                              ),
                              itemSize: 12,
                              unratedColor: Colors.grey.withOpacity(.4),
                              onRatingUpdate: (rating) {
                              },
                            ),
                            const SizedBox(width: 5),
                            Text('(49)',
                                style: GoogleFonts.quicksand(
                                    color: Colors.grey, fontSize: 11)),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 5,
            child: Text(
              '\$ 54.00',
              style: GoogleFonts.quicksand(fontSize: 20, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}