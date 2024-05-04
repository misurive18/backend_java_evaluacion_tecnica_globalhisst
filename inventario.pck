CREATE OR REPLACE NONEDITIONABLE PACKAGE inventario AS
  PROCEDURE sp_insertAndListProducts(idProducto       IN PRODUCTO.PRODUCTO_ID%TYPE,
                                     nombre           IN PRODUCTO.NOMBRE%TYPE,
                                     fec_registro     IN PRODUCTO.FECH_REGISTRO%TYPE,
                                     cursor           OUT SYS_REFCURSOR,
                                     codigoRespuesta  OUT NUMBER,
                                     mensajeRespuesta OUT VARCHAR2);
END inventario;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY INVENTARIO AS

  PROCEDURE SP_INSERTANDLISTPRODUCTS(IDPRODUCTO       IN PRODUCTO.PRODUCTO_ID%TYPE,
                                     NOMBRE           IN PRODUCTO.NOMBRE%TYPE,
                                     FEC_REGISTRO     IN PRODUCTO.FECH_REGISTRO%TYPE,
                                     CURSOR           OUT SYS_REFCURSOR,
                                     CODIGORESPUESTA  OUT NUMBER,
                                     MENSAJERESPUESTA OUT VARCHAR2) AS
  BEGIN
    INSERT INTO PRODUCTO
      (PRODUCTO_ID, NOMBRE, FECH_REGISTRO)
    VALUES
      (IDPRODUCTO, NOMBRE, FEC_REGISTRO);
  
    OPEN CURSOR FOR
      SELECT * FROM PRODUCTO WHERE TRUNC(FECH_REGISTRO) = TRUNC(SYSDATE) order by PRODUCTO_ID;
  
    CODIGORESPUESTA  := 0;
    MENSAJERESPUESTA := 'Ejecucion con  exito';
  EXCEPTION
    WHEN OTHERS THEN
      CODIGORESPUESTA  := 1;
      MENSAJERESPUESTA := 'Error al ejecutar sp: ' || SQLERRM;
  END;
END INVENTARIO;
/
