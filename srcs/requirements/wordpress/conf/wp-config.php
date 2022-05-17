<!-- https://github.com/WordPress/WordPress/blob/master/wp-config-sample.php -->

<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'opacaud' );

/** Database password */
define( 'DB_PASSWORD', '$MYSQL_USER_PWD' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
// https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10
define('AUTH_KEY',         'w)cHyos]~COTTB}Fz:&KNDpCIU]zSR{f Ymn(UppiEn@hXF@=2S-D`{O&CXnd!01');
define('SECURE_AUTH_KEY',  '9Xh*=.a6%Ph,/k$iXqZ5`)5#>,N@| V&E8, 0V!,0O,([|@ ?ggz6nmhzKP}kLEO');
define('LOGGED_IN_KEY',    'fn|@]p,s54.s>Gxc0.PX21Zzp)#-)N[U};M-|m3EqH<08`5)^,,FGE|6A CGJ$nk');
define('NONCE_KEY',        'YJso !B@J`+$&B<BS$+[7-a-z^(>h2-PS-12bKyx|GRv[+#xFgPN$k#PKehQnp?Y');
define('AUTH_SALT',        '5{@6so+xiV1w=_b1|Xtxb@()j^9Z~gZ>lT1PcL-41VL+*EfT.*RWJ-COrMgE3jJG');
define('SECURE_AUTH_SALT', 'pb?2;=NI3ZCo0^_Q}xDqF>7tV`GedXl}ww{hsjD n_8/R(;I-90P-M1&?||/x4v(');
define('LOGGED_IN_SALT',   ']7q2002!l!K?{Q5yKx7xM$qT24p_4ktHEGJvFV|e#0{Z~LZy#F7mP)TT-:^IQ+LJ');
define('NONCE_SALT',       'Tpno j}7,FE- q3W%9>aa3e~HgX_*@ybkq2/&j:EtJmM#*g2v]nah93<z+&5$Hvg');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';