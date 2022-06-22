import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/models/tienda.dart';
import 'package:delivery/models/usuario.dart';
import 'package:delivery/service/auth_service.dart';
import 'package:delivery/service/tiendas_service.dart';
import 'package:delivery/views/socio/editar_tienda_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:we_slide/we_slide.dart';

class SocioDashBoardView extends StatefulWidget {
  const SocioDashBoardView({Key? key}) : super(key: key);

  @override
  State<SocioDashBoardView> createState() => _SocioDashBoardViewState();
}

String tiendaUrl = '';

class _SocioDashBoardViewState extends State<SocioDashBoardView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final _controller = WeSlideController();
    final tiendasService = Provider.of<TiendasService>(context);
    final authServiceService = Provider.of<AuthService>(context);
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: tiendasService.getTienda(tienda: tiendaUrl),
        builder: (BuildContext context, AsyncSnapshot<Tienda?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: const [
                LinearProgressIndicator(
                  minHeight: 1,
                  backgroundColor: Color.fromRGBO(234, 248, 248, 0),
                  color: Color.fromRGBO(62, 204, 191, 1),
                ),
              ],
            );
          }
          var tienda = snapshot.data;

          return AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: snapshot.hasData
                  ? WeSlide(
                      parallax: true,
                      hideAppBar: true,
                      hideFooter: false,
                      backgroundColor: Colors.white,
                      panelBorderRadiusBegin: 20.0,
                      panelBorderRadiusEnd: 20.0,
                      panelMinSize: 0,
                      panelMaxSize: 200,
                      parallaxOffset: 0.3,
                      appBarHeight: 80.0,
                      footerHeight: 60.0,
                      controller: _controller,
                      appBar: AppBar(
                        toolbarHeight: 150,
                        automaticallyImplyLeading: false,
                        leadingWidth: 200,
                        centerTitle: false,
                        titleSpacing: 0,
                        actions: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditarTiendaView(
                                            tienda: tienda!,
                                          )),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 25),
                                child: const Icon(
                                  FontAwesomeIcons.gear,
                                  color: Colors.black,
                                ),
                              ))
                        ],
                        title: Container(
                          padding: const EdgeInsets.only(left: 25),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              _controller.show();
                            },
                            child: Row(children: [
                              Text(
                                tienda!.nombre,
                                style: GoogleFonts.quicksand(
                                    fontSize: 25, color: Colors.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.expand_more,
                                color: Colors.black,
                              ),
                            ]),
                          ),
                        ),
                        leading: null,
                        backgroundColor: Colors.white,
                        elevation: 0,
                      ),
                      body: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(bottom: 90, top: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Hero(
                                          tag: tienda.uid,
                                          child: SizedBox(
                                            width: 170,
                                            height: 170,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: tienda.imagenPerfil,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                            colorFilter:
                                                                ColorFilter
                                                                    .mode(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      .15),
                                                              BlendMode.color,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(100),
                                                          child:
                                                              const CircularProgressIndicator(
                                                            strokeWidth: 1,
                                                            color: Colors.black,
                                                          )),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return const Icon(
                                                        Icons.error);
                                                  }),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 93,
                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 10),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              const MiembroEquipo(),
                                      itemCount: 1,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 170,
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sin pedidos por ahora :(',
                                          style: GoogleFonts.quicksand(
                                            color: Colors.black.withOpacity(.4),
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      panel: Container(
                        height: 150,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: authServiceService.usuario.negocios.length,
                          itemBuilder: (_, int index) {
                            var tiendaPrev =
                                authServiceService.usuario.negocios[index];

                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    tiendaUrl = tiendaPrev.uid;
                                  });
                                  _controller.hide();
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                Colors.grey.withOpacity(.1))),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: tiendaPrev.imagen,
                                            imageBuilder: (context,
                                                    imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Colors.black
                                                            .withOpacity(.15),
                                                        BlendMode.color,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            placeholder: (context, url) =>
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            100),
                                                    child:
                                                        const CircularProgressIndicator(
                                                      strokeWidth: 1,
                                                      color: Colors.black,
                                                    )),
                                            errorWidget: (context, url, error) {
                                              return const Icon(Icons.error);
                                            }),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    tiendaPrev.nombre,
                                    style: GoogleFonts.quicksand(
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 20),
                        ),
                      ),
                      panelHeader: GestureDetector(
                        onTap: () {
                          _controller.show();
                        },
                        child: Container(
                          height: 90.0,
                          color: Colors.white,
                          child: const Center(child: Text("Slide to Up ☝️")),
                        ),
                      ),
                    )
                  : Column(
                      children: const [
                        LinearProgressIndicator(
                          minHeight: 1,
                          backgroundColor: Color.fromRGBO(234, 248, 248, 0),
                          color: Color.fromRGBO(62, 204, 191, 1),
                        ),
                      ],
                    ));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MiembroEquipo extends StatelessWidget {
  const MiembroEquipo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(.2)),
                color: Colors.white,
                shape: BoxShape.circle),
            child: const Icon(
              Icons.add,
              color: Color.fromRGBO(62, 204, 191, 1),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Equipo',
            style: GoogleFonts.quicksand(),
          )
        ],
      ),
    );
  }
}
