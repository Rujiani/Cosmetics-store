import 'package:cosmetics_store/core/widgets/products/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Color(0xFFF4F4F4),
            shadowColor: Colors.transparent,
            child: SizedBox(
              height: 187.64999389648438,
              width: 161.00833129882812,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 13.9, horizontal: 23.17),
                child: Image.asset(product.images.first, fit: BoxFit.contain),
              ),
            ),
          ),

          Expanded(
            child: SizedBox(
              height: 162.1666717529297,
              width: 162.1666717529297,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category,
                    style: TextStyle(fontFamily: 'Raleway', fontSize: 11.58),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    product.name,
                    style: TextStyle(fontFamily: 'Raleway', fontSize: 14),
                  ),

                  Row(
                    children: [
                      Text(
                        NumberFormat.currency(
                          locale: 'ru_RU',
                          symbol: '₽',
                          decimalDigits: 0,
                        ).format(product.price - (product.discount ?? 0)),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      if (product.discount != null)
                        Text(
                          NumberFormat.currency(
                            locale: 'ru_RU',
                            symbol: '₽',
                            decimalDigits: 0,
                          ).format(product.price),
                          style: TextStyle(
                            decoration: product.discount != null
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: Color(0x20000033),
                            decorationColor: Color(0x20000033),
                            decorationThickness: 2,
                            decorationStyle: TextDecorationStyle.solid,
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
