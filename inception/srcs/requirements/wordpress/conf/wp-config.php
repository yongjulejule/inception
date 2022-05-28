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
define( 'DB_NAME', getenv('MYSQL_DATABASE') );

/** Database username */
define( 'DB_USER', getenv('MYSQL_USER') );

/** Database password */
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );

/** Database hostname */
define( 'DB_HOST', '172.10.0.42' );
define( 'DB_PORT', '3306' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', 'utf8mb4_general_ci' );

define( 'WP_CACHE', true );
define( 'WP_CACHE_KEY_SALT', 'sdf/kA!Ba[sdfrAui38>ei<qwe[12~4dsg');
define( 'WP_REDIS_PASSWORD', getenv('WP_REDIS_PASSWORD'));

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

define('AUTH_KEY',         'IaJ|@P*7h$`H|/^-}8/.!YfxVV1[4a!aq?&M%3-OcRJd7jAN=+B#|&VtX(NN+9[Z');
define('SECURE_AUTH_KEY',  '@F+FXX[toVGS4H*bw+.ipIpCV|O?9U<5_^y,GS4D0FtEJ=b>zVx#S+.(dgn&-;~.');
define('LOGGED_IN_KEY',    '{{5s-L]f[)j<<U@+1Zd]yWfmv+bIIh.;!4&az|&-r!/j283pa@i?FE+occ,5ouLY');
define('NONCE_KEY',        'iK*T0/Iq+RM+A.w2N^a#D@O-CeD`,N3J)@2m_U,3|.LC+Nn)dsARAk02NP+-]eSm');
define('AUTH_SALT',        '&_1E]y]ara7p-{yBP^^<JAu~d~-[v*sE]%2^P,Z]SyL!%|rVoU8ye|eV_N_t^q`^');
define('SECURE_AUTH_SALT', '`R,h+zdy&6xE%DWw_/9fmTb(#3>^{88=a6i,,}|n#@=.Wc+KM&S<73c>g!Itop6`');
define('LOGGED_IN_SALT',   '*OB8dZhPp2_%_5D>gsL]>)OtU>/4R)sQoV W|s@WW~9|A@/AAixEG{&d#d+&c]Zr');
define('NONCE_SALT',       'Hlg%|_I,=*=&tMjC>=NIH7Q4g9Z92A<+:5VKx8)}++7|Rn?Bk`=7_$201bK3^SLM');

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
define( 'WP_DEBUG', true );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
