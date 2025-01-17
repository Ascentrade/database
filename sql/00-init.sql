-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.1.2
-- PostgreSQL version: 16.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: database | type: DATABASE --
-- DROP DATABASE IF EXISTS database;
-- CREATE DATABASE database
--	 ENCODING = 'UTF8';
-- ddl-end --


-- object: public.securities | type: TABLE --
-- DROP TABLE IF EXISTS public.securities CASCADE;
CREATE TABLE public.securities (
	id bigserial NOT NULL,
	last_update timestamp NOT NULL DEFAULT NOW(),
	code text NOT NULL,
	type text NOT NULL,
	name text NOT NULL,
	exchange bigint NOT NULL,
	currency bigint NOT NULL,
	country bigint NOT NULL,
	figi text,
	isin text,
	lei text,
	wkn text,
	cusip text,
	cik text,
	tws_con_id bigint,
	ipo_date date,
	is_delisted bool DEFAULT false,
	delisting_date date,
	description text,
	marketcap bigint,
	beta numeric,
	shares_outstanding bigint,
	shares_float bigint,
	shares_short bigint,
	short_ratio numeric,
	short_percent_outstanding numeric,
	short_percent_float numeric,
	has_options bool DEFAULT false,
	url text,
	gics_code bigint,
	sector text,
	industry text,
	logo_url text,
	logo_base64 text,
	ebitda bigint,
	pe_ratio numeric,
	peg_ratio numeric,
	wallstreet_target_price numeric,
	book_value numeric,
	dividend_share numeric,
	dividend_yield numeric,
	earnings_share numeric,
	eps_estimate_current_year numeric,
	eps_estimate_next_year numeric,
	eps_estimate_next_quarter numeric,
	eps_estimate_current_quarter numeric,
	most_recent_quarter date,
	profit_margin numeric,
	operating_margin_ttm numeric,
	return_on_assets_ttm numeric,
	return_on_equity_ttm numeric,
	revenue_ttm bigint,
	revenue_per_share_ttm numeric,
	quarterly_revenue_growth_yoy numeric,
	gross_profit_ttm bigint,
	diluted_eps_ttm numeric,
	quarterly_earnings_growth_yoy numeric,
	forward_pe numeric,
	price_sales_ttm numeric,
	price_book_mrq numeric,
	enterprise_value bigint,
	enterprise_value_revenue numeric,
	enterprise_value_ebitda numeric,
	CONSTRAINT security_id_pk PRIMARY KEY (id),
	CONSTRAINT securities_code_exchange_uq UNIQUE (code,exchange)
);
-- ddl-end --
COMMENT ON COLUMN public.securities.type IS E'Common Stock\nMutual Fund\nCommodity\nFutures\nINDEX\nFUND\nETF';
-- ddl-end --
COMMENT ON COLUMN public.securities.figi IS E'Financial Instrument Global Identifier (FIGI), formerly Bloomberg Global Identifier (BBGID)';
-- ddl-end --
COMMENT ON COLUMN public.securities.isin IS E'International Securities Identification Number';
-- ddl-end --
COMMENT ON COLUMN public.securities.lei IS E'Legal Entity Identifier';
-- ddl-end --
COMMENT ON COLUMN public.securities.wkn IS E'Wertpapierkennnummer (only Germany)';
-- ddl-end --
COMMENT ON COLUMN public.securities.cusip IS E'Committee on Uniform Security Identification Procedures';
-- ddl-end --
COMMENT ON COLUMN public.securities.cik IS E'Central Index Key (CIK) is a unique number by the United States Securities and Exchange Commission. Used to identify company related filings in online databases like Electronic Data Gathering, Analysis, and Retrieval (EDGAR).';
-- ddl-end --
COMMENT ON COLUMN public.securities.tws_con_id IS E'ConID for this security. Used to get data from Interactive Brokers Traders Workstation API.\nhttps://interactivebrokers.github.io/tws-api/basic_contracts.html';
-- ddl-end --
COMMENT ON COLUMN public.securities.delisting_date IS E'Date of delisting.';
-- ddl-end --
COMMENT ON COLUMN public.securities.marketcap IS E'shares_outstanding * stock_price';
-- ddl-end --
COMMENT ON COLUMN public.securities.gics_code IS E'GICS Code';
-- ddl-end --
COMMENT ON COLUMN public.securities.sector IS E'Not GIC standard sector name.';
-- ddl-end --
COMMENT ON COLUMN public.securities.industry IS E'Not GIC standard industry name.';
-- ddl-end --
COMMENT ON COLUMN public.securities.logo_url IS E'Link to the logo image.';
-- ddl-end --
COMMENT ON COLUMN public.securities.logo_base64 IS E'BASE64 encoded logo.';
-- ddl-end --
ALTER TABLE public.securities OWNER TO postgres;
-- ddl-end --

-- object: public.quotes | type: TABLE --
-- DROP TABLE IF EXISTS public.quotes CASCADE;
CREATE TABLE public.quotes (
	security bigserial NOT NULL,
	date date NOT NULL,
	open numeric,
	high numeric,
	low numeric,
	close numeric,
	split_adjusted_open numeric,
	split_adjusted_high numeric,
	split_adjusted_low numeric,
	split_adjusted_close numeric,
	adjusted_close numeric,
	volume numeric,
	CONSTRAINT security_date_uq UNIQUE (security,date)
);
-- ddl-end --
COMMENT ON COLUMN public.quotes.open IS E'raw';
-- ddl-end --
COMMENT ON COLUMN public.quotes.high IS E'raw';
-- ddl-end --
COMMENT ON COLUMN public.quotes.low IS E'raw';
-- ddl-end --
COMMENT ON COLUMN public.quotes.close IS E'raw';
-- ddl-end --
COMMENT ON COLUMN public.quotes.split_adjusted_open IS E'Only split adjusted open price';
-- ddl-end --
COMMENT ON COLUMN public.quotes.split_adjusted_high IS E'Only split adjusted high price';
-- ddl-end --
COMMENT ON COLUMN public.quotes.split_adjusted_low IS E'Only split adjusted low price';
-- ddl-end --
COMMENT ON COLUMN public.quotes.split_adjusted_close IS E'Only split adjusted close price';
-- ddl-end --
COMMENT ON COLUMN public.quotes.adjusted_close IS E'Total adjusted for splits and dividends.\nUsed for calculations about correlation etc.';
-- ddl-end --
COMMENT ON COLUMN public.quotes.volume IS E'Number of traded shares on a specific day.';
-- ddl-end --
ALTER TABLE public.quotes OWNER TO postgres;
-- ddl-end --

-- object: public.currencies | type: TABLE --
-- DROP TABLE IF EXISTS public.currencies CASCADE;
CREATE TABLE public.currencies (
	id bigserial NOT NULL,
	name text NOT NULL,
	iso_code text NOT NULL,
	fractional_unit text,
	number_to_basic bigint,
	CONSTRAINT currency_id_pk PRIMARY KEY (id),
	CONSTRAINT symbol_uq UNIQUE (iso_code)
);
-- ddl-end --
ALTER TABLE public.currencies OWNER TO postgres;
-- ddl-end --

INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'1', E'United Arab Emirates dirham', E'AED', E'Fils', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'2', E'Afghan afghani', E'AFN', E'Pul', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'3', E'Albanian lek', E'ALL', E'Qintar', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'4', E'Armenian dram', E'AMD', E'Luma', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'5', E'Netherlands Antillean guilder', E'ANG', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'6', E'Angolan kwanza', E'AOA', E'Cêntimo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'7', E'Argentine peso', E'ARS', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'8', E'Australian dollar', E'AUD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'9', E'Aruban florin', E'AWG', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'10', E'Azerbaijani manat', E'AZN', E'Qəpik', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'11', E'Bosnia and Herzegovina convertible mark', E'BAM', E'Fening', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'12', E'Barbadian dollar', E'BBD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'13', E'Bangladeshi taka', E'BDT', E'Poisha', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'14', E'Bulgarian lev', E'BGN', E'Stotinka', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'15', E'Bahraini dinar', E'BHD', E'Fils', E'1000');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'16', E'Burundian franc', E'BIF', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'17', E'Bermudian dollar', E'BMD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'18', E'Brunei dollar', E'BND', E'Sen', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'19', E'Bolivian boliviano', E'BOB', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'20', E'Brazilian real', E'BRL', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'21', E'Bahamian dollar', E'BSD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'22', E'Bitcoin', E'BTC', E'Satoshi', E'100000000');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'23', E'Bhutanese ngultrum', E'BTN', E'Chetrum', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'24', E'Botswana pula', E'BWP', E'Thebe', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'25', E'Belarusian ruble', E'BYN', E'Copeck', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'26', E'Belize dollar', E'BZD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'27', E'Canadian dollar', E'CAD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'28', E'Congolese franc', E'CDF', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'29', E'Swiss franc', E'CHF', E'Rappen', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'30', E'Chilean peso', E'CLP', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'31', E'Renminbi', E'CNY', E'Jiao', E'10');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'32', E'Colombian peso', E'COP', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'33', E'Costa Rican colón', E'CRC', E'Céntimo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'34', E'Cuban peso', E'CUP', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'35', E'Cape Verdean escudo', E'CVE', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'36', E'Czech koruna', E'CZK', E'Heller', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'37', E'Djiboutian franc', E'DJF', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'38', E'Danish krone', E'DKK', E'Øre', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'39', E'Dominican peso', E'DOP', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'40', E'Algerian dinar', E'DZD', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'41', E'Egyptian pound', E'EGP', E'Piastre', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'42', E'Eritrean nakfa', E'ERN', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'43', E'Ethiopian birr', E'ETB', E'Santim', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'44', E'Euro', E'EUR', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'45', E'Fijian dollar', E'FJD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'46', E'Falkland Islands pound', E'FKP', E'Penny', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'47', E'Sterling', E'GBP', E'Penny', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'48', E'Georgian lari', E'GEL', E'Tetri', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'49', E'Ghanaian cedi', E'GHS', E'Pesewa', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'50', E'Gibraltar pound', E'GIP', E'Penny', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'51', E'Gambian dalasi', E'GMD', E'Butut', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'52', E'Guinean franc', E'GNF', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'53', E'Guatemalan quetzal', E'GTQ', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'54', E'Guyanese dollar', E'GYD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'55', E'Hong Kong dollar', E'HKD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'56', E'Honduran lempira', E'HNL', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'57', E'Haitian gourde', E'HTG', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'58', E'Hungarian forint', E'HUF', E'Fillér', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'59', E'Indonesian rupiah', E'IDR', E'Sen', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'60', E'Israeli new shekel', E'ILS', E'Agora', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'61', E'Indian rupee', E'INR', E'Paisa', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'62', E'Iraqi dinar', E'IQD', E'Fils', E'1000');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'63', E'Iranian rial', E'IRR', E'Rial', E'1');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'64', E'Icelandic króna', E'ISK', E'Eyrir', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'65', E'Jamaican dollar', E'JMD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'66', E'Jordanian dinar', E'JOD', E'Piastre', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'67', E'Japanese yen', E'JPY', E'Sen', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'68', E'Kenyan shilling', E'KES', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'69', E'Kyrgyz som', E'KGS', E'Tyiyn', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'70', E'Cambodian riel', E'KHR', E'Sen', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'71', E'Comorian franc', E'KMF', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'72', E'North Korean won', E'KPW', E'Chon', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'73', E'South Korean won', E'KRW', E'Jeon', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'74', E'Kuwaiti dinar', E'KWD', E'Fils', E'1000');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'75', E'Cayman Islands dollar', E'KYD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'76', E'Kazakhstani tenge', E'KZT', E'Tıyn', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'77', E'Lao kip', E'LAK', E'Att', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'78', E'Lebanese pound', E'LBP', E'Piastre', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'79', E'Sri Lankan rupee', E'LKR', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'80', E'Liberian dollar', E'LRD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'81', E'Lesotho loti', E'LSL', E'Sente', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'82', E'Libyan dinar', E'LYD', E'Dirham', E'1000');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'83', E'Moroccan dirham', E'MAD', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'84', E'Moldovan leu', E'MDL', E'Ban', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'85', E'Malagasy ariary', E'MGA', E'Iraimbilanja', E'5');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'86', E'Macedonian denar', E'MKD', E'Deni', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'87', E'Burmese kyat', E'MMK', E'Pya', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'88', E'Mongolian tögrög', E'MNT', E'Möngö', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'89', E'Macanese pataca', E'MOP', E'Avo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'90', E'Mauritanian ouguiya', E'MRU', E'Khoums', E'5');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'91', E'Mauritian rupee', E'MUR', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'92', E'Maldivian rufiyaa', E'MVR', E'Laari', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'93', E'Malawian kwacha', E'MWK', E'Tambala', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'94', E'Mexican peso', E'MXN', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'95', E'Malaysian ringgit', E'MYR', E'Sen', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'96', E'Mozambican metical', E'MZN', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'97', E'Namibian dollar', E'NAD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'98', E'Nigerian naira', E'NGN', E'Kobo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'99', E'Nicaraguan córdoba', E'NIO', E'Centavo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'100', E'Norwegian krone', E'NOK', E'Øre', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'101', E'Nepalese rupee', E'NPR', E'Paisa', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'102', E'New Zealand dollar', E'NZD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'103', E'Omani rial', E'OMR', E'Baisa', E'1000');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'104', E'Panamanian balboa', E'PAB', E'Centésimo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'105', E'Peruvian sol', E'PEN', E'Céntimo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'106', E'Papua New Guinean kina', E'PGK', E'Toea', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'107', E'Philippine peso', E'PHP', E'Sentimo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'108', E'Pakistani rupee', E'PKR', E'Paisa', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'109', E'Polish złoty', E'PLN', E'Grosz', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'110', E'Paraguayan guaraní', E'PYG', E'Céntimo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'111', E'Qatari riyal', E'QAR', E'Dirham', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'112', E'Romanian leu', E'RON', E'Ban', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'113', E'Serbian dinar', E'RSD', E'Para', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'114', E'Russian ruble', E'RUB', E'Kopeck', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'115', E'Rwandan franc', E'RWF', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'116', E'Saudi riyal', E'SAR', E'Halala', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'117', E'Solomon Islands dollar', E'SBD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'118', E'Seychellois rupee', E'SCR', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'119', E'Sudanese pound', E'SDG', E'Piastre', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'120', E'Swedish krona', E'SEK', E'Öre', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'121', E'Singapore dollar', E'SGD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'122', E'Saint Helena pound', E'SHP', E'Penny', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'123', E'Sierra Leonean leone', E'SLE', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'124', E'Somali shilling', E'SOS', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'125', E'Surinamese dollar', E'SRD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'126', E'South Sudanese pound', E'SSP', E'Piaster', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'127', E'São Tomé and Príncipe dobra', E'STN', E'Cêntimo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'128', E'Syrian pound', E'SYP', E'Piastre', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'129', E'Swazi lilangeni', E'SZL', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'130', E'Thai baht', E'THB', E'Satang', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'131', E'Tajikistani somoni', E'TJS', E'Diram', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'132', E'Turkmenistani manat', E'TMT', E'Tenge', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'133', E'Tunisian dinar', E'TND', E'Millime', E'1000');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'134', E'Tongan paʻanga', E'TOP', E'Seniti', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'135', E'Turkish lira', E'TRY', E'Kuruş', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'136', E'Trinidad and Tobago dollar', E'TTD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'137', E'New Taiwan dollar', E'TWD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'138', E'Tanzanian shilling', E'TZS', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'139', E'Ukrainian hryvnia', E'UAH', E'Kopeck', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'140', E'Ugandan shilling', E'UGX', DEFAULT, DEFAULT);
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'141', E'United States dollar', E'USD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'142', E'Uruguayan peso', E'UYU', E'Centésimo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'143', E'Uzbekistani sum', E'UZS', E'Tiyin', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'144', E'Venezuelan digital bolívar', E'VED', E'Céntimo', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'145', E'Venezuelan sovereign bolívar', E'VES', E'Céntimo', E'1');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'146', E'Vietnamese đồng', E'VND', E'Hào', E'10');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'147', E'Vanuatu vatu', E'VUV', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'148', E'Samoan tālā', E'WST', E'Sene', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'149', E'Central African CFA franc', E'XAF', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'150', E'Eastern Caribbean dollar', E'XCD', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'151', E'West African CFA franc', E'XOF', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'152', E'CFP franc', E'XPF', E'Centime', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'153', E'Yemeni rial', E'YER', E'Fils', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'154', E'South African rand', E'ZAR', E'Cent', E'100');
-- ddl-end --
INSERT INTO public.currencies (id, name, iso_code, fractional_unit, number_to_basic) VALUES (E'155', E'Zambian kwacha', E'ZMW', E'Ngwee', E'100');
-- ddl-end --

-- object: public.analyst_ratings | type: TABLE --
-- DROP TABLE IF EXISTS public.analyst_ratings CASCADE;
CREATE TABLE public.analyst_ratings (
	security bigint NOT NULL,
	date_added date NOT NULL DEFAULT CURRENT_DATE,
	rating numeric,
	target_price numeric,
	strong_buy smallint NOT NULL DEFAULT 0,
	buy smallint NOT NULL DEFAULT 0,
	hold smallint NOT NULL DEFAULT 0,
	sell smallint NOT NULL DEFAULT 0,
	strong_sell smallint NOT NULL DEFAULT 0

);
-- ddl-end --
COMMENT ON TABLE public.analyst_ratings IS E'Average from analyst ratings';
-- ddl-end --
ALTER TABLE public.analyst_ratings OWNER TO postgres;
-- ddl-end --

-- object: public.exchanges | type: TABLE --
-- DROP TABLE IF EXISTS public.exchanges CASCADE;
CREATE TABLE public.exchanges (
	id bigserial NOT NULL,
	name text NOT NULL,
	code text NOT NULL,
	code_alias text,
	operating_mic text,
	country bigint,
	currency bigint,
	virtual_exchange text,
	timezone text,
	working_days text,
	open time,
	close time,
	open_utc time,
	close_utc time,
	CONSTRAINT exchanges_id_pk PRIMARY KEY (id),
	CONSTRAINT exchanges_code_uq UNIQUE (code),
	CONSTRAINT exchanges_name_uq UNIQUE (name)
);
-- ddl-end --
COMMENT ON COLUMN public.exchanges.code_alias IS E'Alias for the exchange name\nNYSE MKT -> AMEX\nUsed for TradingView exchange name';
-- ddl-end --
ALTER TABLE public.exchanges OWNER TO postgres;
-- ddl-end --

INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'1', E'USA Stocks', E'US', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'2', E'NASDAQ', E'NASDAQ', E'XNAS', E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'3', E'New York Stock Exchange', E'NYSE', E'XNYS', E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'4', E'Cboe BZX U.S. Equities Exchange', E'BATS', E'BATS', E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'5', E'NYSE MKT', E'NYSE MKT', E'XASE', E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'6', E'NYSE ARCA', E'NYSE ARCA', E'ARCX', E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'7', E'London Exchange', E'LSE', E'XLON', E'235', E'47', DEFAULT, E'Europe/London', E'Mon,Tue,Wed,Thu,Fri', E'08:00:00', E'16:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'8', E'NEO Exchange', E'NEO', E'NEOE', E'41', E'27', DEFAULT, E'America/Toronto', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'9', E'TSX Venture Exchange', E'V', E'XTSX', E'41', E'27', DEFAULT, E'America/Toronto', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'10', E'Toronto Exchange', E'TO', E'XTSE', E'41', E'27', DEFAULT, E'America/Toronto', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'11', E'Germany Stocks', E'DE', DEFAULT, E'84', E'44', E'DE', E'Europe/Berlin', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'12', E'Berlin Exchange', E'BE', E'XBER', E'84', E'44', DEFAULT, E'Europe/Berlin', E'Mon,Tue,Wed,Thu,Fri', E'08:00:00', E'20:00:00', E'07:00:00', E'19:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'13', E'Hamburg Exchange', E'HM', E'XHAM', E'84', E'44', DEFAULT, E'Europe/Berlin', E'Mon,Tue,Wed,Thu,Fri', E'08:00:00', E'20:00:00', E'07:00:00', E'19:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'14', E'XETRA Exchange', E'XETRA', E'XETR', E'84', E'44', DEFAULT, E'Europe/Berlin', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'15', E'Dusseldorf Exchange', E'DU', E'XDUS', E'84', E'44', DEFAULT, E'Europe/Berlin', E'Mon,Tue,Wed,Thu,Fri', E'08:00:00', E'20:00:00', E'07:00:00', E'19:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'16', E'Munich Exchange', E'MU', E'XMUN', E'84', E'44', DEFAULT, E'Europe/Berlin', E'Mon,Tue,Wed,Thu,Fri', E'08:00:00', E'20:00:00', E'07:00:00', E'19:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'17', E'Hanover Exchange', E'HA', E'XHAN', E'84', E'44', DEFAULT, E'Europe/Berlin', E'Mon,Tue,Wed,Thu,Fri', E'08:00:00', E'20:00:00', E'07:00:00', E'19:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'18', E'Frankfurt Exchange', E'F', E'XFRA', E'84', E'44', DEFAULT, E'Europe/Berlin', E'Mon,Tue,Wed,Thu,Fri', E'08:00:00', E'22:00:00', E'07:00:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'19', E'Stuttgart Exchange', E'STU', E'XSTU', E'84', E'44', DEFAULT, E'Europe/Berlin', E'Mon,Tue,Wed,Thu,Fri', E'08:00:00', E'22:00:00', E'07:00:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'20', E'Vienna Exchange', E'VI', E'XWBO', E'15', E'44', DEFAULT, E'Europe/Vienna', E'Mon,Tue,Wed,Thu,Fri', E'08:55:00', E'17:35:00', E'07:55:00', E'16:35:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'21', E'Luxembourg Stock Exchange', E'LU', E'XLUX', E'131', E'44', DEFAULT, E'Europe/Luxembourg', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'22', E'Euronext Paris', E'PA', E'XPAR', E'77', E'44', DEFAULT, E'Europe/Paris', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'23', E'Euronext Brussels', E'BR', E'XBRU', E'22', E'44', DEFAULT, E'Europe/Brussels', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'24', E'Madrid Exchange', E'MC', E'BMEX', E'210', E'44', DEFAULT, E'Europe/Rome', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'25', E'SIX Swiss Exchange', E'SW', E'XSWX', E'216', E'29', DEFAULT, E'Europe/Zurich', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'26', E'Euronext Lisbon', E'LS', E'XLIS', E'179', E'44', DEFAULT, E'Europe/Lisbon', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'09:00:00', E'17:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'27', E'Euronext Amsterdam', E'AS', E'XAMS', E'157', E'44', DEFAULT, E'Europe/Amsterdam', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:40:00', E'08:00:00', E'16:40:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'28', E'Stockholm Exchange', E'ST', E'XSTO', E'215', E'120', DEFAULT, E'Europe/Stockholm', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'29', E'Irish Exchange', E'IR', E'XDUB', E'108', E'44', DEFAULT, E'Europe/Dublin', E'Mon,Tue,Wed,Thu,Fri', E'08:00:00', E'16:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'30', E'Copenhagen Exchange', E'CO', E'XCSE', E'61', E'38', DEFAULT, E'Europe/Copenhagen', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:00:00', E'08:00:00', E'16:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'31', E'Oslo Stock Exchange', E'OL', E'XOSL', E'167', E'100', DEFAULT, E'Europe/Oslo', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'32', E'Iceland Exchange', E'IC', E'XICE', E'103', E'64', DEFAULT, E'Atlantic/Reykjavik', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'15:30:00', E'09:30:00', E'15:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'33', E'Helsinki Exchange', E'HE', E'XHEL', E'76', E'44', DEFAULT, E'Europe/Helsinki', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'18:30:00', E'08:00:00', E'16:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'34', E'Malawi Stock Exchange', E'MSE', E'XMSW', E'134', E'93', DEFAULT, E'Africa/Blantyre', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'15:00:00', E'07:00:00', E'13:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'35', E'Egyptian Exchange', E'EGX', E'NILX', E'66', E'41', DEFAULT, E'Africa/Cairo', E'Mon,Tue,Wed,Thu,Sun', E'10:00:00', E'14:15:00', E'08:00:00', E'12:15:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'36', E'Botswana Stock Exchange ', E'XBOT', E'XBOT', E'30', E'24', DEFAULT, E'Africa/Gaborone', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'14:00:00', E'08:00:00', E'12:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'37', E'Ghana Stock Exchange', E'GSE', E'XGHA', E'85', E'49', DEFAULT, E'Africa/Accra', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'15:00:00', E'10:00:00', E'15:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'38', E'Regional Securities Exchange', E'BRVM', E'XBRV', E'55', E'151', DEFAULT, E'Africa/Abidjan', E'Mon,Tue,Wed,Thu,Fri', E'09:45:00', E'14:00:00', E'09:45:00', E'14:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'39', E'Prague Stock Exchange ', E'PR', E'XPRA', E'60', E'36', DEFAULT, E'Europe/Prague', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'16:10:00', E'08:00:00', E'15:10:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'40', E'Nairobi Securities Exchange', E'XNAI', E'XNAI', E'117', E'68', DEFAULT, E'Africa/Nairobi', E'Mon,Tue,Wed,Thu,Fri', E'09:31:00', E'15:00:00', E'06:31:00', E'12:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'41', E'Casablanca Stock Exchange', E'BC', E'XCAS', E'151', E'83', DEFAULT, E'Africa/Casablanca', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'15:20:00', E'08:30:00', E'14:20:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'42', E'Stock Exchange of Mauritius', E'SEM', E'XMAU', E'142', E'91', DEFAULT, E'Indian/Mauritius', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'14:30:00', E'06:00:00', E'10:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'43', E'Nigerian Stock Exchange', E'XNSA', E'XNSA', E'162', E'98', DEFAULT, E'Africa/Lagos', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'14:20:00', E'09:00:00', E'13:20:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'44', E'Rwanda Stock Exchange', E'RSE', E'RSEX', E'185', DEFAULT, DEFAULT, E'Africa/Kigali', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'12:00:00', E'07:00:00', E'10:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'45', E'Dar es Salaam Stock Exchange', E'DSE', E'XDAR', E'220', E'138', DEFAULT, E'Africa/Dar_es_Salaam', E'Mon,Tue,Wed,Thu,Fri', E'10:30:00', E'16:00:00', E'07:30:00', E'13:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'46', E'Uganda Securities Exchange', E'USE', E'XUGA', E'232', E'140', DEFAULT, E'Africa/Kampala', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'12:00:00', E'07:00:00', E'09:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'47', E'Lusaka Stock Exchange', E'LUSE', E'XLUS', E'248', E'155', DEFAULT, E'Africa/Lusaka', E'Mon,Tue,Wed,Thu,Fri', E'11:00:00', E'14:00:00', E'09:00:00', E'12:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'48', E'Tel Aviv Exchange', E'TA', E'XTAE', E'110', E'60', DEFAULT, E'Asia/Jerusalem', E'Mon,Tue,Wed,Thu,Sun', E'09:45:00', E'17:25:00', E'07:45:00', E'15:25:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'49', E'Zimbabwe Stock Exchange', E'XZIM', E'XZIM', E'249', DEFAULT, DEFAULT, E'Africa/Harare', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'13:00:00', E'07:30:00', E'11:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'50', E'Victoria Falls Stock Exchange', E'VFEX', E'VFEX', E'249', DEFAULT, DEFAULT, E'Africa/Harare', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'13:00:00', E'07:30:00', E'11:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'51', E'KOSDAQ', E'KQ', E'XKOS', E'120', E'73', DEFAULT, E'Asia/Seoul', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'15:30:00', E'00:00:00', E'06:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'52', E'Korea Stock Exchange', E'KO', E'XKRX', E'120', E'73', DEFAULT, E'Asia/Seoul', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'15:30:00', E'00:00:00', E'06:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'53', E'Budapest Stock Exchange', E'BUD', E'XBUD', E'102', E'58', DEFAULT, E'Europe/Budapest', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:00:00', E'08:00:00', E'16:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'54', E'Warsaw Stock Exchange', E'WAR', E'XWAR', E'178', E'109', DEFAULT, E'Europe/Warsaw', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:00:00', E'08:00:00', E'16:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'55', E'Philippine Stock Exchange', E'PSE', E'XPHS', E'176', E'107', DEFAULT, E'Asia/Manila', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'15:30:00', E'01:30:00', E'07:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'56', E'Chilean Stock Exchange', E'SN', E'XSGO', E'45', E'30', DEFAULT, E'America/Santiago', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'12:30:00', E'19:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'57', E'Johannesburg Exchange', E'JSE', E'XJSE', E'207', E'154', DEFAULT, E'Africa/Johannesburg', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'17:00:00', E'07:00:00', E'15:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'58', E'Jakarta Exchange', E'JK', E'XIDX', E'105', E'59', DEFAULT, E'Asia/Jakarta', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'15:50:00', E'02:00:00', E'08:50:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'59', E'Thailand Exchange', E'BK', E'XBKK', E'221', E'130', DEFAULT, E'Asia/Bangkok', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'16:30:00', E'03:00:00', E'09:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'60', E'Shanghai Exchange', E'SHG', E'XSHG', E'46', E'31', DEFAULT, E'Asia/Shanghai', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'15:00:00', E'01:30:00', E'07:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'61', E'NSE (India)', E'NSE', E'XNSE', E'104', E'61', DEFAULT, E'Asia/Calcutta', E'Mon,Tue,Wed,Thu,Fri', E'09:15:00', E'15:30:00', E'03:45:00', E'10:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'62', E'Athens Exchange', E'AT', E'ASEX', E'87', E'44', DEFAULT, E'Europe/Athens', E'Mon,Tue,Wed,Thu,Fri', E'10:15:00', E'17:20:00', E'08:15:00', E'15:20:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'63', E'Saudi Arabia Exchange', E'SR', E'XSAU', E'196', E'116', DEFAULT, E'Asia/Riyadh', E'Mon,Tue,Wed,Thu,Sun', E'10:00:00', E'15:20:00', E'07:00:00', E'12:20:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'64', E'Shenzhen Exchange', E'SHE', E'XSHE', E'46', E'31', DEFAULT, E'Asia/Shanghai', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'15:00:00', E'01:30:00', E'07:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'65', E'Karachi Stock Exchange', E'KAR', E'XKAR', E'169', E'108', DEFAULT, E'Asia/Karachi', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'15:30:00', E'04:30:00', E'10:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'66', E'Australia Exchange', E'AU', E'XASX', E'14', E'8', DEFAULT, E'Australia/Sydney', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'16:10:00', E'23:00:00', E'05:10:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'67', E'Colombo Stock Exchange', E'CM', E'XCOL', E'211', E'79', DEFAULT, E'Asia/Colombo', E'Mon,Tue,Wed,Thu,Fri', E'10:30:00', E'14:30:00', E'05:00:00', E'09:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'68', E'Vietnam Stocks', E'VN', E'HSTC', E'242', E'146', DEFAULT, E'Asia/Ho_Chi_Minh', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'15:00:00', E'02:00:00', E'08:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'69', E'Kuala Lumpur Exchange', E'KLSE', E'XKLS', E'135', E'95', DEFAULT, E'Asia/Kuala_Lumpur', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'16:45:00', E'01:00:00', E'08:45:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'70', E'Buenos Aires Exchange', E'BA', E'XBUE', E'11', E'7', DEFAULT, E'America/Buenos_Aires', E'Mon,Tue,Wed,Thu,Fri', E'11:00:00', E'17:00:00', E'14:00:00', E'20:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'71', E'Bucharest Stock Exchange', E'RO', E'XBSE', E'183', E'112', DEFAULT, E'Europe/Bucharest', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'17:45:00', E'08:00:00', E'15:45:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'72', E'Sao Paolo Exchange', E'SA', E'BVMF', E'32', E'20', DEFAULT, E'America/Sao_Paulo', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'18:00:00', E'13:00:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'73', E'Mexican Exchange', E'MX', E'XMEX', E'144', E'94', DEFAULT, E'America/Mexico_City', E'Mon,Tue,Wed,Thu,Fri', E'08:30:00', E'15:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'74', E'Zagreb Stock Exchange', E'ZSE', E'XZAG', E'56', E'44', DEFAULT, E'Europe/Zagreb', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'16:00:00', E'08:00:00', E'15:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'75', E'Taiwan OTC Exchange', E'TWO', E'ROCO', E'218', E'137', DEFAULT, E'Asia/Taipei', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'13:30:00', E'01:00:00', E'05:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'76', E'MICEX Moscow Russia', E'MCX', DEFAULT, E'184', E'114', DEFAULT, E'Europe/Moscow', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'23:50:00', E'07:00:00', E'20:50:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'77', E'Taiwan Exchange', E'TW', E'XTAI', E'218', E'137', DEFAULT, E'Asia/Taipei', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'13:30:00', E'01:00:00', E'05:30:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'78', E'Bolsa de Valores de Lima', E'LIM', E'XLIM', E'175', E'105', DEFAULT, E'America/Lima', E'Mon,Tue,Wed,Thu,Fri', E'08:30:00', E'14:52:00', E'13:30:00', E'19:52:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'79', E'Money Market Virtual Exchange', E'MONEY', DEFAULT, DEFAULT, DEFAULT, DEFAULT, E'Europe/Paris', E'Mon,Tue,Wed,Thu,Fri', E'09:00:00', E'16:00:00', E'08:00:00', E'15:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'80', E'Europe Fund Virtual Exchange', E'EUFUND', DEFAULT, DEFAULT, E'44', DEFAULT, E'UTC', E'Mon,Tue,Wed,Thu,Fri', E'00:00:00', E'00:00:00', E'00:00:00', E'00:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'81', E'Istanbul Stock Exchange', E'IS', E'XIST', E'228', E'135', DEFAULT, E'Europe/Istanbul', E'Mon,Tue,Wed,Thu,Fri', E'10:00:00', E'18:00:00', E'07:00:00', E'15:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'82', E'FOREX', E'FOREX', E'CDSL', DEFAULT, DEFAULT, DEFAULT, E'UTC', E'Mon,Tue,Wed,Thu,Fri,Sat,Sun', E'00:00:00', E'23:59:00', E'00:00:00', E'23:59:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'83', E'Cryptocurrencies', E'CC', E'CRYP', DEFAULT, DEFAULT, DEFAULT, E'UTC', E'Mon,Tue,Wed,Thu,Fri,Sat,Sun', E'00:00:00', E'23:59:00', E'00:00:00', E'23:59:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'84', E'PINK', E'PINK', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'85', E'AMEX', E'AMEX', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'86', E'NMFQS', E'NMFQS', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'87', E'OTC', E'OTC', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'88', E'OTCQX', E'OTCQX', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'89', E'OTCQB', E'OTCQB', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'90', E'OTCMKTS', E'OTCMKTS', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'91', E'OTCGREY', E'OTCGREY', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'92', E'OTCCE', E'OTCCE', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --
INSERT INTO public.exchanges (id, name, code, operating_mic, country, currency, virtual_exchange, timezone, working_days, open, close, open_utc, close_utc) VALUES (E'93', E'OTCBB', E'OTCBB', DEFAULT, E'237', E'141', E'US', E'America/New_York', E'Mon,Tue,Wed,Thu,Fri', E'09:30:00', E'16:00:00', E'14:30:00', E'21:00:00');
-- ddl-end --

-- object: public.earnings | type: TABLE --
-- DROP TABLE IF EXISTS public.earnings CASCADE;
CREATE TABLE public.earnings (
	security bigint NOT NULL,
	date date NOT NULL,
	report_date date NOT NULL,
	before_after text DEFAULT '?',
	eps_actual numeric,
	eps_estimate numeric,
	eps_difference numeric,
	surprise_percent numeric,
	CONSTRAINT earnings_security_date_uq UNIQUE (security,date)
);
-- ddl-end --
COMMENT ON COLUMN public.earnings.date IS E'Fiscal year quarter date';
-- ddl-end --
COMMENT ON COLUMN public.earnings.report_date IS E'Date of earnings report';
-- ddl-end --
ALTER TABLE public.earnings OWNER TO postgres;
-- ddl-end --

-- object: public.option_expirations | type: TABLE --
-- DROP TABLE IF EXISTS public.option_expirations CASCADE;
CREATE TABLE public.option_expirations (
	security bigint NOT NULL,
	expiration date NOT NULL,
	date date NOT NULL,
	implied_volatility numeric,
	put_volume bigint,
	call_volume bigint,
	put_open_interest bigint,
	call_open_interest bigint,
	max_pain numeric,
	CONSTRAINT option_expirations_security_expiration_date_uq UNIQUE (security,date,expiration)
);
-- ddl-end --
COMMENT ON COLUMN public.option_expirations.date IS E'Date of the historical snapshop.';
-- ddl-end --
COMMENT ON COLUMN public.option_expirations.max_pain IS E'Maximum pain underlying price for this expiration date.';
-- ddl-end --
ALTER TABLE public.option_expirations OWNER TO postgres;
-- ddl-end --

-- object: public.option_contracts | type: TABLE --
-- DROP TABLE IF EXISTS public.option_contracts CASCADE;
CREATE TABLE public.option_contracts (
	security bigint NOT NULL,
	contract_name text NOT NULL,
	contract_size text,
	contract_period text NOT NULL,
	type text NOT NULL,
	last_trade_date date NOT NULL,
	expiration_date date NOT NULL,
	strike numeric NOT NULL,
	last_price numeric,
	bid numeric,
	ask numeric,
	theoretical_price numeric,
	volume bigint,
	open_interest bigint,
	implied_volatility numeric,
	delta numeric,
	gamma numeric,
	theta numeric,
	vega numeric,
	roh numeric,
	CONSTRAINT option_contract_uq UNIQUE (security,type,last_trade_date,expiration_date,strike)
);
-- ddl-end --
COMMENT ON COLUMN public.option_contracts.contract_name IS E'AAPL210730C00070000';
-- ddl-end --
COMMENT ON COLUMN public.option_contracts.contract_size IS E'REGULAR';
-- ddl-end --
COMMENT ON COLUMN public.option_contracts.contract_period IS E'WEEKLY or MONTHLY';
-- ddl-end --
COMMENT ON COLUMN public.option_contracts.type IS E'PUT or CALL';
-- ddl-end --
ALTER TABLE public.option_contracts OWNER TO postgres;
-- ddl-end --

-- object: public.volatility | type: TABLE --
-- DROP TABLE IF EXISTS public.volatility CASCADE;
CREATE TABLE public.volatility (
	security bigint NOT NULL,
	date date NOT NULL,
	iv numeric,
	hv numeric,
	ivr numeric,
	ivp numeric,
	CONSTRAINT iv_security_date_uq UNIQUE (security,date)
);
-- ddl-end --
COMMENT ON TABLE public.volatility IS E'Historic underlying volatility and current options implied volatility.';
-- ddl-end --
COMMENT ON COLUMN public.volatility.iv IS E'Implied volatility 30 day from options';
-- ddl-end --
COMMENT ON COLUMN public.volatility.hv IS E'historic volatility 30 days';
-- ddl-end --
COMMENT ON COLUMN public.volatility.ivr IS E'Implied Volatility Rank 52 weeks';
-- ddl-end --
COMMENT ON COLUMN public.volatility.ivp IS E'Implied Volatility Percentil 52 weeks';
-- ddl-end --
ALTER TABLE public.volatility OWNER TO postgres;
-- ddl-end --

-- object: public.dividends | type: TABLE --
-- DROP TABLE IF EXISTS public.dividends CASCADE;
CREATE TABLE public.dividends (
	security bigint NOT NULL,
	date date NOT NULL,
	declaration_date date,
	record_date date,
	payment_date date,
	period text,
	adjusted_value numeric,
	value numeric NOT NULL,
	CONSTRAINT dividends_security_date_uq UNIQUE (security,date)
);
-- ddl-end --
COMMENT ON COLUMN public.dividends.period IS E'"Quarterly"';
-- ddl-end --
ALTER TABLE public.dividends OWNER TO postgres;
-- ddl-end --

-- object: public.splits | type: TABLE --
-- DROP TABLE IF EXISTS public.splits CASCADE;
CREATE TABLE public.splits (
	security bigint NOT NULL,
	date date NOT NULL,
	"old" numeric NOT NULL,
	"new" numeric NOT NULL,
	CONSTRAINT splits_security_date_uq UNIQUE (security,date)
);
-- ddl-end --
COMMENT ON TABLE public.splits IS E'3.000000/1.000000\nYou get 3 shares for every 1 share\nold = 1\nnew = 3';
-- ddl-end --
ALTER TABLE public.splits OWNER TO postgres;
-- ddl-end --

-- object: public.addresses | type: TABLE --
-- DROP TABLE IF EXISTS public.addresses CASCADE;
CREATE TABLE public.addresses (
	security bigint NOT NULL,
	country bigint,
	street text,
	city text,
	state text,
	zip text,
	CONSTRAINT addresses_security_uq UNIQUE (security)
);
-- ddl-end --
COMMENT ON TABLE public.addresses IS E'One or more addresses related with a company.';
-- ddl-end --
ALTER TABLE public.addresses OWNER TO postgres;
-- ddl-end --

-- object: public.forex_pair_quotes | type: TABLE --
-- DROP TABLE IF EXISTS public.forex_pair_quotes CASCADE;
CREATE TABLE public.forex_pair_quotes (
	base bigint NOT NULL,
	quote bigint NOT NULL,
	date date NOT NULL,
	open numeric,
	high numeric,
	low numeric,
	close numeric NOT NULL,
	CONSTRAINT base_quote_date_uq UNIQUE (base,quote,date)
);
-- ddl-end --
COMMENT ON COLUMN public.forex_pair_quotes.base IS E'Base currency\nBASE / QUOTE';
-- ddl-end --
COMMENT ON COLUMN public.forex_pair_quotes.quote IS E'Quote currency\nBASE / QUOTE';
-- ddl-end --
COMMENT ON COLUMN public.forex_pair_quotes.close IS E'Close price of this day.';
-- ddl-end --
ALTER TABLE public.forex_pair_quotes OWNER TO postgres;
-- ddl-end --

-- object: public.annual_earnings | type: TABLE --
-- DROP TABLE IF EXISTS public.annual_earnings CASCADE;
CREATE TABLE public.annual_earnings (
	security bigint NOT NULL,
	date date NOT NULL,
	eps numeric NOT NULL,
	pe_ratio numeric,
	CONSTRAINT annual_earnings_security_date_uq UNIQUE (security,date)
);
-- ddl-end --
COMMENT ON COLUMN public.annual_earnings.pe_ratio IS E'Price-Earnings-Ratio self calculated.\nAlso available in security_highlights table from EOD.';
-- ddl-end --
ALTER TABLE public.annual_earnings OWNER TO postgres;
-- ddl-end --

-- object: public.insider_transactions | type: TABLE --
-- DROP TABLE IF EXISTS public.insider_transactions CASCADE;
CREATE TABLE public.insider_transactions (
	security bigint NOT NULL,
	date date NOT NULL,
	report_date date,
	owner_cik text,
	owner_name text NOT NULL,
	owner_relationship text,
	owner_title text,
	transaction_date date NOT NULL,
	transaction_code text NOT NULL,
	transaction_amount bigint NOT NULL,
	transaction_price numeric NOT NULL,
	transaction_acquired_disposed text,
	post_transaction_amount bigint,
	sec_link text,
	CONSTRAINT insiders_security_date_name_uq UNIQUE (security,date,owner_name)
);
-- ddl-end --
COMMENT ON COLUMN public.insider_transactions.date IS E'This date is the transaction date.';
-- ddl-end --
COMMENT ON COLUMN public.insider_transactions.transaction_code IS E'S = Sell\nP = Purchase';
-- ddl-end --
COMMENT ON COLUMN public.insider_transactions.transaction_acquired_disposed IS E'A or D';
-- ddl-end --
COMMENT ON COLUMN public.insider_transactions.sec_link IS E'URL to the SEC filing.\nMostly a XML file to download.';
-- ddl-end --
ALTER TABLE public.insider_transactions OWNER TO postgres;
-- ddl-end --

-- object: public.etf_data | type: TABLE --
-- DROP TABLE IF EXISTS public.etf_data CASCADE;
CREATE TABLE public.etf_data (
	security bigint NOT NULL,
	company_name text,
	company_url text,
	etf_url text,
	yield numeric,
	dividend_paying_frequency text,
	inception_date date,
	total_assets bigint,
	holdings_count smallint,
	CONSTRAINT etf_data_security_uq UNIQUE (security)
);
-- ddl-end --
COMMENT ON TABLE public.etf_data IS E'Special data if security is an ETF.';
-- ddl-end --
COMMENT ON COLUMN public.etf_data.dividend_paying_frequency IS E'Monthly, Quarterly, Yearly';
-- ddl-end --
ALTER TABLE public.etf_data OWNER TO postgres;
-- ddl-end --

-- object: public.etf_holdings | type: TABLE --
-- DROP TABLE IF EXISTS public.etf_holdings CASCADE;
CREATE TABLE public.etf_holdings (
	etf bigint NOT NULL,
	security bigint,
	assets_percent numeric,
	code text,
	exchange text,
	name text,
	gics_code bigint,
	sector text,
	industry text,
	country bigint,
	region text

);
-- ddl-end --
COMMENT ON COLUMN public.etf_holdings.etf IS E'Security ID of the ETF.';
-- ddl-end --
COMMENT ON COLUMN public.etf_holdings.security IS E'Security ID of a single asset in this ETF.';
-- ddl-end --
COMMENT ON COLUMN public.etf_holdings.assets_percent IS E'Percentage value of holding.';
-- ddl-end --
COMMENT ON COLUMN public.etf_holdings.gics_code IS E'GICS Code';
-- ddl-end --
ALTER TABLE public.etf_holdings OWNER TO postgres;
-- ddl-end --

-- object: public.balance_sheets | type: TABLE --
-- DROP TABLE IF EXISTS public.balance_sheets CASCADE;
CREATE TABLE public.balance_sheets (
	security bigint NOT NULL,
	date date NOT NULL,
	quarterly bool NOT NULL,
	filing_date date,
	total_assets bigint,
	intangible_assets bigint,
	earning_assets bigint,
	other_current_assets bigint,
	total_liab bigint,
	total_stockholder_equity bigint,
	deferred_long_term_liab bigint,
	other_current_liab bigint,
	common_stock bigint,
	retained_earnings bigint,
	other_liab bigint,
	good_will bigint,
	other_assets bigint,
	cash bigint,
	total_current_liabilities bigint,
	net_debt bigint,
	short_term_debt bigint,
	short_long_term_debt bigint,
	short_long_term_debt_total bigint,
	other_stockholder_equity bigint,
	property_plant_equipment bigint,
	total_current_assets bigint,
	long_term_investments bigint,
	net_tangible_assets bigint,
	short_term_investments bigint,
	net_receivables bigint,
	long_term_debt bigint,
	inventory bigint,
	accounts_payable bigint,
	total_permanent_equity bigint,
	noncontrolling_interest_in_consolidated_entity bigint,
	temporary_equity_redeemable_noncontrolling_interests bigint,
	accumulated_other_comprehensive_income bigint,
	additional_paid_in_capital bigint,
	common_stock_total_equity bigint,
	preferred_stock_total_equity bigint,
	retained_earnings_total_equity bigint,
	treasury_stock bigint,
	accumulated_amortization bigint,
	non_currrent_assets_other bigint,
	deferred_long_term_asset_charges bigint,
	non_current_assets_total bigint,
	capital_lease_obligations bigint,
	long_term_debt_total bigint,
	non_current_liabilities_other bigint,
	non_current_liabilities_total bigint,
	negative_goodwill bigint,
	warrants bigint,
	preferred_stock_redeemable bigint,
	capital_surpluse bigint,
	liabilities_and_stockholders_equity bigint,
	cash_and_short_term_investments bigint,
	property_plant_and_equipment_gross bigint,
	accumulated_depreciation bigint,
	net_working_capital bigint,
	net_invested_capital bigint,
	common_stock_shares_outstanding bigint,
	CONSTRAINT balance_sheet_security_date_quarterly_uq UNIQUE (security,date,quarterly)
);
-- ddl-end --
COMMENT ON COLUMN public.balance_sheets.quarterly IS E'quarterly = true\nyearly = false';
-- ddl-end --
ALTER TABLE public.balance_sheets OWNER TO postgres;
-- ddl-end --

-- object: public.cash_flows | type: TABLE --
-- DROP TABLE IF EXISTS public.cash_flows CASCADE;
CREATE TABLE public.cash_flows (
	security bigint NOT NULL,
	date date NOT NULL,
	quarterly bool NOT NULL,
	filing_date date,
	investments bigint,
	change_to_liabilities bigint,
	total_cashflows_from_investing_activities bigint,
	net_borrowings bigint,
	total_cash_from_financing_activities bigint,
	change_to_operating_activities bigint,
	net_income bigint,
	change_in_cash bigint,
	begin_period_cash_flow bigint,
	end_period_cash_flow bigint,
	total_cash_from_operating_activities bigint,
	depreciation bigint,
	other_cashflows_from_investing_activities bigint,
	dividends_paid bigint,
	change_to_inventory bigint,
	change_to_account_receivables bigint,
	sale_purchase_of_stock bigint,
	other_cashflows_from_financing_activities bigint,
	change_to_netincome bigint,
	capital_expenditures bigint,
	change_receivables bigint,
	cash_flows_other_operating bigint,
	exchange_rate_changes bigint,
	cash_and_cash_equivalents_changes bigint,
	change_in_working_capital bigint,
	other_non_cash_items bigint,
	free_cash_flow bigint,
	CONSTRAINT cash_flow_security_date_quarterly_uq UNIQUE (security,date,quarterly)
);
-- ddl-end --
COMMENT ON COLUMN public.cash_flows.quarterly IS E'quarterly = true\nyearly = false';
-- ddl-end --
ALTER TABLE public.cash_flows OWNER TO postgres;
-- ddl-end --

-- object: public.income_statements | type: TABLE --
-- DROP TABLE IF EXISTS public.income_statements CASCADE;
CREATE TABLE public.income_statements (
	security bigint NOT NULL,
	date date NOT NULL,
	quarterly bool NOT NULL,
	filing_date date,
	research_development bigint,
	effect_of_accounting_charges bigint,
	income_before_tax bigint,
	minority_interest bigint,
	net_income bigint,
	selling_general_administrative bigint,
	selling_and_marketing_expenses bigint,
	gross_profit bigint,
	reconciled_depreciation bigint,
	ebit bigint,
	ebitda bigint,
	depreciation_and_amortization bigint,
	non_operating_income_net_other bigint,
	operating_income bigint,
	other_operating_expenses bigint,
	interest_expense bigint,
	tax_provision bigint,
	interest_income bigint,
	net_interest_income bigint,
	extraordinary_items bigint,
	non_recurring bigint,
	other_items bigint,
	income_tax_expense bigint,
	total_revenue bigint,
	total_operating_expenses bigint,
	cost_of_revenue bigint,
	total_other_income_expense_net bigint,
	discontinued_operations bigint,
	net_income_from_continuing_ops bigint,
	net_income_applicable_to_common_shares bigint,
	preferred_stock_and_other_adjustments bigint,
	CONSTRAINT income_statement_security_date_quarterly_uq UNIQUE (security,date,quarterly)
);
-- ddl-end --
COMMENT ON COLUMN public.income_statements.quarterly IS E'quarterly = true\nyearly = false';
-- ddl-end --
ALTER TABLE public.income_statements OWNER TO postgres;
-- ddl-end --

-- object: public.officers | type: TABLE --
-- DROP TABLE IF EXISTS public.officers CASCADE;
CREATE TABLE public.officers (
	security bigint NOT NULL,
	name text NOT NULL,
	title text NOT NULL,
	year_born smallint

);
-- ddl-end --
ALTER TABLE public.officers OWNER TO postgres;
-- ddl-end --

-- object: option_contracts_contract_name_last_trade_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.option_contracts_contract_name_last_trade_date_idx CASCADE;
CREATE INDEX option_contracts_contract_name_last_trade_date_idx ON public.option_contracts
USING btree
(
	contract_name,
	last_trade_date
);
-- ddl-end --

-- object: insider_transactions_security_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.insider_transactions_security_date_idx CASCADE;
CREATE INDEX insider_transactions_security_date_idx ON public.insider_transactions
USING btree
(
	security,
	date
);
-- ddl-end --

-- object: volatility_security_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.volatility_security_date_idx CASCADE;
CREATE INDEX volatility_security_date_idx ON public.volatility
USING btree
(
	security,
	date
);
-- ddl-end --

-- object: splits_security_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.splits_security_date_idx CASCADE;
CREATE INDEX splits_security_date_idx ON public.splits
USING btree
(
	security,
	date
);
-- ddl-end --

-- object: options_expirations_security_expiration_last_trade_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.options_expirations_security_expiration_last_trade_date_idx CASCADE;
CREATE INDEX options_expirations_security_expiration_last_trade_date_idx ON public.option_expirations
USING btree
(
	security,
	expiration,
	date
);
-- ddl-end --

-- object: analyst_ratings_security_rating_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.analyst_ratings_security_rating_idx CASCADE;
CREATE INDEX analyst_ratings_security_rating_idx ON public.analyst_ratings
USING btree
(
	security,
	rating
);
-- ddl-end --

-- object: dividends_security_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.dividends_security_date_idx CASCADE;
CREATE INDEX dividends_security_date_idx ON public.dividends
USING btree
(
	security,
	date
);
-- ddl-end --

-- object: income_statements_quarterly_security_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.income_statements_quarterly_security_date_idx CASCADE;
CREATE INDEX income_statements_quarterly_security_date_idx ON public.income_statements
USING btree
(
	quarterly,
	security,
	date
);
-- ddl-end --

-- object: cash_flows_quarterly_security_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.cash_flows_quarterly_security_date_idx CASCADE;
CREATE INDEX cash_flows_quarterly_security_date_idx ON public.cash_flows
USING btree
(
	quarterly,
	security,
	date
);
-- ddl-end --

-- object: balance_sheets_quarterly_security_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.balance_sheets_quarterly_security_date_idx CASCADE;
CREATE INDEX balance_sheets_quarterly_security_date_idx ON public.balance_sheets
USING btree
(
	quarterly,
	security,
	date
);
-- ddl-end --

-- object: securities_delisted_type_options_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.securities_delisted_type_options_idx CASCADE;
CREATE INDEX securities_delisted_type_options_idx ON public.securities
USING btree
(
	is_delisted,
	type,
	has_options
);
-- ddl-end --

-- object: public.exchange_holidays | type: TABLE --
-- DROP TABLE IF EXISTS public.exchange_holidays CASCADE;
CREATE TABLE public.exchange_holidays (
	exchange bigint NOT NULL,
	date date NOT NULL,
	name text NOT NULL,
	half_day boolean NOT NULL DEFAULT FALSE,
	info text,
	CONSTRAINT exchange_date_name_uq UNIQUE (exchange,date,name)
);
-- ddl-end --
COMMENT ON COLUMN public.exchange_holidays.half_day IS E'True if shorter trading on this day.';
-- ddl-end --
COMMENT ON COLUMN public.exchange_holidays.info IS E'Additional information like ''public'' or ''official''';
-- ddl-end --
ALTER TABLE public.exchange_holidays OWNER TO postgres;
-- ddl-end --

-- object: base_quote_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.base_quote_date_idx CASCADE;
CREATE INDEX base_quote_date_idx ON public.forex_pair_quotes
USING btree
(
	base,
	quote,
	date
);
-- ddl-end --

-- object: securities_lower_code_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.securities_lower_code_idx CASCADE;
CREATE INDEX securities_lower_code_idx ON public.securities
USING btree
(
	(lower(code))
);
-- ddl-end --

-- object: securities_lower_name_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.securities_lower_name_idx CASCADE;
CREATE INDEX securities_lower_name_idx ON public.securities
USING btree
(
	(lower(name))
);
-- ddl-end --

-- object: securities_lower_isin_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.securities_lower_isin_idx CASCADE;
CREATE INDEX securities_lower_isin_idx ON public.securities
USING btree
(
	(lower(isin))
);
-- ddl-end --

-- object: public.option_contracts_last | type: TABLE --
-- DROP TABLE IF EXISTS public.option_contracts_last CASCADE;
CREATE TABLE public.option_contracts_last (
	security bigint NOT NULL,
	contract_name text NOT NULL,
	contract_size text,
	contract_period text NOT NULL,
	type text NOT NULL,
	last_trade_date date NOT NULL,
	expiration_date date NOT NULL,
	strike numeric NOT NULL,
	last_price numeric,
	bid numeric,
	ask numeric,
	theoretical_price numeric,
	volume bigint,
	open_interest bigint,
	implied_volatility numeric,
	delta numeric,
	gamma numeric,
	theta numeric,
	vega numeric,
	roh numeric,
	CONSTRAINT option_contract_last_uq UNIQUE (security,type,expiration_date,strike)
);
-- ddl-end --
COMMENT ON TABLE public.option_contracts_last IS E'Just keep data of the last trading day';
-- ddl-end --
COMMENT ON COLUMN public.option_contracts_last.contract_name IS E'AAPL210730C00070000';
-- ddl-end --
COMMENT ON COLUMN public.option_contracts_last.contract_size IS E'REGULAR';
-- ddl-end --
COMMENT ON COLUMN public.option_contracts_last.contract_period IS E'WEEKLY or MONTHLY';
-- ddl-end --
COMMENT ON COLUMN public.option_contracts_last.type IS E'PUT or CALL';
-- ddl-end --
ALTER TABLE public.option_contracts_last OWNER TO postgres;
-- ddl-end --

-- object: option_contracts_contract_name_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.option_contracts_contract_name_idx CASCADE;
CREATE INDEX option_contracts_contract_name_idx ON public.option_contracts_last
USING btree
(
	contract_name
);
-- ddl-end --

-- object: public.option_expirations_last | type: TABLE --
-- DROP TABLE IF EXISTS public.option_expirations_last CASCADE;
CREATE TABLE public.option_expirations_last (
	security bigint NOT NULL,
	last_trade_date date NOT NULL,
	expiration_date date NOT NULL,
	implied_volatility numeric NOT NULL,
	put_volume bigint NOT NULL,
	call_volume bigint NOT NULL,
	put_open_interest bigint NOT NULL,
	call_open_interest bigint NOT NULL,
	max_pain numeric,
	CONSTRAINT option_expirations_last_security_date_uq UNIQUE (security,expiration_date)
);
-- ddl-end --
COMMENT ON COLUMN public.option_expirations_last.max_pain IS E'Maximum pain underlying price for this expiration date.';
-- ddl-end --
ALTER TABLE public.option_expirations_last OWNER TO postgres;
-- ddl-end --

-- object: options_expirations_last_security_expiration_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.options_expirations_last_security_expiration_idx CASCADE;
CREATE INDEX options_expirations_last_security_expiration_idx ON public.option_expirations_last
USING btree
(
	security,
	expiration_date
);
-- ddl-end --

-- object: quotes_security_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.quotes_security_date_idx CASCADE;
CREATE INDEX quotes_security_date_idx ON public.quotes
USING btree
(
	security,
	date
);
-- ddl-end --

-- object: annual_earnings_security_date_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.annual_earnings_security_date_idx CASCADE;
CREATE INDEX annual_earnings_security_date_idx ON public.annual_earnings
USING btree
(
	security,
	date
);
-- ddl-end --

-- object: exchanges_code_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.exchanges_code_idx CASCADE;
CREATE INDEX exchanges_code_idx ON public.exchanges
USING btree
(
	code
);
-- ddl-end --

-- object: currencies_symbol_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.currencies_symbol_idx CASCADE;
CREATE INDEX currencies_symbol_idx ON public.currencies
USING btree
(
	iso_code
);
-- ddl-end --

-- object: public.gics_codes | type: TABLE --
-- DROP TABLE IF EXISTS public.gics_codes CASCADE;
CREATE TABLE public.gics_codes (
	id bigint NOT NULL,
	sector text NOT NULL,
	industry_group text,
	industry text,
	sub_industry text,
	description text,
	CONSTRAINT gics_id_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.gics_codes IS E'GICS code, name and description.\nhttps://en.wikipedia.org/wiki/Global_Industry_Classification_Standard';
-- ddl-end --
COMMENT ON COLUMN public.gics_codes.id IS E'GICS ID';
-- ddl-end --
ALTER TABLE public.gics_codes OWNER TO postgres;
-- ddl-end --

INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'10', E'Energy', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15', E'Materials', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20', E'Industrials', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25', E'Consumer Discretionary', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30', E'Consumer Staples', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35', E'Health Care', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40', E'Financials', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45', E'Information Technology', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50', E'Communication Services', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'55', E'Utilities', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60', E'Real Estate', E'null', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'1010', E'Energy', E'Energy', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'1510', E'Materials', E'Materials', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'2010', E'Industrials', E'Capital Goods', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'2020', E'Industrials', E'Commercial  & Professional Services', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'2030', E'Industrials', E'Transportation', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'2510', E'Consumer Discretionary', E'Automobiles & Components', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'2520', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'2530', E'Consumer Discretionary', E'Consumer Services', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'2550', E'Consumer Discretionary', E'Retailing', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'3010', E'Consumer Staples', E'Food & Staples Retailing', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'3020', E'Consumer Staples', E'Food, Beverage & Tobacco', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'3030', E'Consumer Staples', E'Household & Personal Products', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'3510', E'Health Care', E'Health Care Equipment & Services', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'3520', E'Health Care', E'Pharmaceuticals, Biotechnology & Life Sciences', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'4010', E'Financials', E'Banks', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'4020', E'Financials', E'Diversified Financials', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'4030', E'Financials', E'Insurance', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'4510', E'Information Technology', E'Software & Services', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'4520', E'Information Technology', E'Technology Hardware & Equipment', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'4530', E'Information Technology', E'Semiconductors & Semiconductor Equipment', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'5010', E'Communication Services', E'Telecommunication Services', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'5020', E'Communication Services', E'Media & Entertainment', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'5510', E'Utilities', E'Utilities', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'6010', E'Real Estate', E'Real Estate', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'6020', E'Real Estate', E'Real Estate Management & Development', E'null', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'101010', E'Energy', E'Energy', E'Energy Equipment & Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'101020', E'Energy', E'Energy', E'Oil, Gas & Consumable Fuels', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'151010', E'Materials', E'Materials', E'Chemicals', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'151020', E'Materials', E'Materials', E'Construction Materials', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'151030', E'Materials', E'Materials', E'Containers & Packaging', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'151040', E'Materials', E'Materials', E'Metals & Mining', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'151050', E'Materials', E'Materials', E'Paper & Forest Products', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'201010', E'Industrials', E'Capital Goods', E'Aerospace & Defense', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'201020', E'Industrials', E'Capital Goods', E'Building Products', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'201030', E'Industrials', E'Capital Goods', E'Construction & Engineering', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'201040', E'Industrials', E'Capital Goods', E'Electrical Equipment', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'201050', E'Industrials', E'Capital Goods', E'Industrial Conglomerates', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'201060', E'Industrials', E'Capital Goods', E'Machinery', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'201070', E'Industrials', E'Capital Goods', E'Trading Companies & Distributors', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'202010', E'Industrials', E'Commercial  & Professional Services', E'Commercial Services & Supplies', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'202020', E'Industrials', E'Commercial  & Professional Services', E'Professional Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'203010', E'Industrials', E'Transportation', E'Air Freight & Logistics', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'203020', E'Industrials', E'Transportation', E'Airlines', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'203030', E'Industrials', E'Transportation', E'Marine', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'203040', E'Industrials', E'Transportation', E'Road & Rail', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'203050', E'Industrials', E'Transportation', E'Transportation Infrastructure', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'251010', E'Consumer Discretionary', E'Automobiles & Components', E'Auto Components', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'251020', E'Consumer Discretionary', E'Automobiles & Components', E'Automobiles', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'252010', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Household Durables', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'252020', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Leisure Products', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'252030', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Textiles, Apparel & Luxury Goods', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'253010', E'Consumer Discretionary', E'Consumer Services', E'Hotels, Restaurants & Leisure', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'253020', E'Consumer Discretionary', E'Consumer Services', E'Diversified Consumer Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'255010', E'Consumer Discretionary', E'Retailing', E'Distributors', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'255020', E'Consumer Discretionary', E'Retailing', E'Internet & Direct Marketing Retail', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'255030', E'Consumer Discretionary', E'Retailing', E'Multiline Retail', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'255040', E'Consumer Discretionary', E'Retailing', E'Specialty Retail', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'301010', E'Consumer Staples', E'Food & Staples Retailing', E'Food & Staples Retailing', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'302010', E'Consumer Staples', E'Food, Beverage & Tobacco', E'Beverages', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'302020', E'Consumer Staples', E'Food, Beverage & Tobacco', E'Food Products', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'302030', E'Consumer Staples', E'Food, Beverage & Tobacco', E'Tobacco', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'303010', E'Consumer Staples', E'Household & Personal Products', E'Household Products', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'303020', E'Consumer Staples', E'Household & Personal Products', E'Personal Products', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'351010', E'Health Care', E'Health Care Equipment & Services', E'Health Care Equipment & Supplies', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'351020', E'Health Care', E'Health Care Equipment & Services', E'Health Care Providers & Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'351030', E'Health Care', E'Health Care Equipment & Services', E'Health Care Technology', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'352010', E'Health Care', E'Pharmaceuticals, Biotechnology & Life Sciences', E'Biotechnology', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'352020', E'Health Care', E'Pharmaceuticals, Biotechnology & Life Sciences', E'Pharmaceuticals', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'352030', E'Health Care', E'Pharmaceuticals, Biotechnology & Life Sciences', E'Life Sciences Tools & Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'401010', E'Financials', E'Banks', E'Banks', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'401020', E'Financials', E'Banks', E'Thrifts & Mortgage Finance', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'402010', E'Financials', E'Diversified Financials', E'Diversified Financial Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'402020', E'Financials', E'Diversified Financials', E'Consumer Finance', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'402030', E'Financials', E'Diversified Financials', E'Capital Markets', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'402040', E'Financials', E'Diversified Financials', E'Mortgage Real Estate Investment Trusts (REITs)', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'403010', E'Financials', E'Insurance', E'Insurance', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'451020', E'Information Technology', E'Software & Services', E'IT Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'451030', E'Information Technology', E'Software & Services', E'Software', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'452010', E'Information Technology', E'Technology Hardware & Equipment', E'Communications Equipment', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'452020', E'Information Technology', E'Technology Hardware & Equipment', E'Technology Hardware, Storage & Peripherals', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'452030', E'Information Technology', E'Technology Hardware & Equipment', E'Electronic Equipment, Instruments & Components', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'453010', E'Information Technology', E'Semiconductors & Semiconductor Equipment', E'Semiconductors & Semiconductor Equipment', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'501010', E'Communication Services', E'Telecommunication Services', E'Diversified Telecommunication Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'501020', E'Communication Services', E'Telecommunication Services', E'Wireless Telecommunication Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'502010', E'Communication Services', E'Media & Entertainment', E'Media', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'502020', E'Communication Services', E'Media & Entertainment', E'Entertainment', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'502030', E'Communication Services', E'Media & Entertainment', E'Interactive Media & Services', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'551010', E'Utilities', E'Utilities', E'Electric Utilities', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'551020', E'Utilities', E'Utilities', E'Gas Utilities', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'551030', E'Utilities', E'Utilities', E'Multi-Utilities', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'551040', E'Utilities', E'Utilities', E'Water Utilities', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'551050', E'Utilities', E'Utilities', E'Independent Power and Renewable Electricity Producers', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'601010', E'Real Estate', E'Real Estate', E'Diversified REITs', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'601020', E'Real Estate', E'Real Estate', E'Real Estate Management & Development', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'601025', E'Real Estate', E'Real Estate', E'Industrial REITs', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'601030', E'Real Estate', E'Real Estate', E'Hotel & Resort REITs', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'601040', E'Real Estate', E'Real Estate', E'Office REITs', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'601050', E'Real Estate', E'Real Estate', E'Health Care REITs', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'601060', E'Real Estate', E'Real Estate', E'Residential REITs', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'601070', E'Real Estate', E'Real Estate', E'Retail REITs', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'601080', E'Real Estate', E'Real Estate', E'Specialized REITs', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'602010', E'Real Estate', E'Real Estate Management & Development', E'Real Estate Management & Development', E'null', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'10101010', E'Energy', E'Energy', E'Energy Equipment & Services', E'Oil & Gas Drilling', E'Drilling contractors or owners of drilling rigs that contract their services for drilling wells');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'10101020', E'Energy', E'Energy', E'Energy Equipment & Services', E'Oil & Gas Equipment & Services', E'Manufacturers of equipment, including drilling rigs and equipment, and providers of supplies and services to companies involved in the drilling, evaluation and completion of oil and gas wells.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'10102010', E'Energy', E'Energy', E'Oil, Gas & Consumable Fuels', E'Integrated Oil & Gas', E'Integrated oil companies engaged in the exploration & production of oil and gas, as well as at least one other significant activity in either refining, marketing and transportation, or chemicals.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'10102020', E'Energy', E'Energy', E'Oil, Gas & Consumable Fuels', E'Oil & Gas Exploration & Production', E'Companies engaged in the exploration and production of oil and gas not classified elsewhere.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'10102030', E'Energy', E'Energy', E'Oil, Gas & Consumable Fuels', E'Oil & Gas Refining & Marketing', E'Companies engaged in the refining and marketing of oil, gas and/or refined products not classified in the Integrated Oil & Gas or Independent Power Producers & Energy Traders Sub-Industries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'10102040', E'Energy', E'Energy', E'Oil, Gas & Consumable Fuels', E'Oil & Gas Storage & Transportation', E'Companies engaged in the storage and/or transportation of oil, gas and/or refined products. Includes diversified midstream natural gas companies, oil and refined product pipelines, coal slurry pipelines and oil & gas shipping companies.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'10102050', E'Energy', E'Energy', E'Oil, Gas & Consumable Fuels', E'Coal & Consumable Fuels', E'Companies primarily involved in the production and mining of coal, related products and other consumable fuels related to the generation of energy.  Excludes companies primarily producing gases classified in the Industrial Gases sub-industry and companies primarily mining for metallurgical (coking) coal used for steel production.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15101010', E'Materials', E'Materials', E'Chemicals', E'Commodity Chemicals', E'Companies that primarily produce industrial chemicals and basic chemicals. Including but not limited to plastics, synthetic fibers, films, commodity-based paints & pigments, explosives and petrochemicals. Excludes chemicalcompanies classified in the Diversified Chemicals, Fertilizers & Agricultural Chemicals, Industrial Gases, or Specialty Chemicals Sub-Industries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15101020', E'Materials', E'Materials', E'Chemicals', E'Diversified Chemicals', E'Manufacturers of a diversified range of chemical products not classified in the Industrial Gases, Commodity Chemicals, Specialty Chemicals or Fertilizers & Agricultural Chemicals Sub-Industries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15101030', E'Materials', E'Materials', E'Chemicals', E'Fertilizers & Agricultural Chemicals', E'Producers of fertilizers, pesticides, potash or other agriculture-related chemicals not classified elsewhere.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15101040', E'Materials', E'Materials', E'Chemicals', E'Industrial Gases', E'Manufacturers of industrial gases.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15101050', E'Materials', E'Materials', E'Chemicals', E'Specialty Chemicals', E'Companies that primarily produce high value-added chemicals used in the manufacture of a wide variety of products, including but not limited to fine chemicals, additives, advanced polymers, adhesives, sealants and specialty paints, pigments and coatings.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15102010', E'Materials', E'Materials', E'Construction Materials', E'Construction Materials', E'Manufacturers of construction materials including sand, clay, gypsum, lime, aggregates, cement, concrete and bricks. Other finished or semi-finished building materials are classified  in the Building Products Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15103010', E'Materials', E'Materials', E'Containers & Packaging', E'Metal & Glass Containers', E'Manufacturers of metal, glass or plastic containers. Includes corks and caps.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15103020', E'Materials', E'Materials', E'Containers & Packaging', E'Paper Packaging', E'Manufacturers of paper and cardboard containers and packaging.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15104010', E'Materials', E'Materials', E'Metals & Mining', E'Aluminum', E'Producers of aluminum and related products, including companies that mine or process bauxite and companies that recycle aluminum to produce finished or semi-finished products. Excludes companies that primarily produce aluminum building materials classified in the Building Products Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15104020', E'Materials', E'Materials', E'Metals & Mining', E'Diversified Metals & Mining', E'Companies engaged in the diversified production or extraction of metals and minerals not classified elsewhere. Including, but not limited to, nonferrous metal mining (except bauxite), salt and borate mining, phosphate rock mining, and diversified mining operations. Excludes iron ore mining, classified in the Steel Sub-Industry, bauxite mining, classified in the Aluminum Sub-Industry, and coal mining, classified in either the Steel or Coal & Consumable Fuels Sub-Industries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15104025', E'Materials', E'Materials', E'Metals & Mining', E'Copper', E'Companies involved primarily in copper ore mining. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15104030', E'Materials', E'Materials', E'Metals & Mining', E'Gold', E'Producers of gold and related products, including companies that mine or process gold and the South African finance houses which primarily invest in, but do not operate, gold mines.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15104040', E'Materials', E'Materials', E'Metals & Mining', E'Precious Metals & Minerals', E'Companies mining precious metals and minerals not classified in the Gold Sub-Industry. Includes companies primarily mining platinum.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15104045', E'Materials', E'Materials', E'Metals & Mining', E'Silver', E'Companies primarily mining silver. Excludes companies classified in the Gold or Precious Metals & Minerals Sub-Industries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15104050', E'Materials', E'Materials', E'Metals & Mining', E'Steel', E'Producers of iron and steel and related products, including metallurgical (coking) coal mining used for steel production.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15105010', E'Materials', E'Materials', E'Paper & Forest Products', E'Forest Products', E'Manufacturers of timber and related wood products. Includes lumber for the building industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'15105020', E'Materials', E'Materials', E'Paper & Forest Products', E'Paper Products', E'Manufacturersof all grades of paper. Excludes companies specializing in paper packaging classified in the Paper Packaging Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20101010', E'Industrials', E'Capital Goods', E'Aerospace & Defense', E'Aerospace & Defense', E'Manufacturers of civil or military aerospace and defense equipment, parts or products. Includes defense electronics and space equipment.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20102010', E'Industrials', E'Capital Goods', E'Building Products', E'Building Products', E'Manufacturers of building components and home improvement products and equipment. Excludes lumber and plywood classified under Forest Products and cement and other materials classified in the Construction Materials Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20103010', E'Industrials', E'Capital Goods', E'Construction & Engineering', E'Construction & Engineering', E'Companies engaged in primarily non-residential construction. Includes civil engineering companies and large-scale contractors. Excludes companies classified in the Homebuilding Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20104010', E'Industrials', E'Capital Goods', E'Electrical Equipment', E'Electrical Components & Equipment', E'Companies that produce electric cables and wires, electrical components or equipment not classified in the Heavy Electrical Equipment Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20104020', E'Industrials', E'Capital Goods', E'Electrical Equipment', E'Heavy Electrical Equipment', E'Manufacturers of power-generating equipment and other heavy electrical equipment, including power turbines, heavy electrical machinery intended for fixed-use and large electrical systems. Excludes cables and wires, classified in the Electrical Components & Equipment Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20105010', E'Industrials', E'Capital Goods', E'Industrial Conglomerates', E'Industrial Conglomerates', E'Diversified industrial companies with business activities in three or more sectors, none of which contributes a majority of revenues. Stakes held are predominantly of a controlling nature and stake holders maintain an operational interest in the running of the subsidiaries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20106010', E'Industrials', E'Capital Goods', E'Machinery', E'Construction Machinery & Heavy Trucks', E'Manufacturers of heavy duty trucks, rolling machinery, earth-moving and construction equipment, and manufacturers of related parts. Includes non-military shipbuilding.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20106015', E'Industrials', E'Capital Goods', E'Machinery', E'Agricultural & Farm Machinery', E'Companies manufacturing agricultural machinery, farm machinery, and their related parts. Includes machinery used for the production of crops and agricultural livestock, agricultural tractors, planting and fertilizing machinery, fertilizer and chemical application equipment, and grain dryers and blowers.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20106020', E'Industrials', E'Capital Goods', E'Machinery', E'Industrial Machinery', E'Manufacturers of industrial machinery and industrial components. Includes companies that manufacture presses, machine tools, compressors, pollution control equipment, elevators, escalators, insulators, pumps, roller bearings and other metal fabrications.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20107010', E'Industrials', E'Capital Goods', E'Trading Companies & Distributors', E'Trading Companies & Distributors', E'Trading companies and other distributors of industrial equipment and products.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20201010', E'Industrials', E'Commercial  & Professional Services', E'Commercial Services & Supplies', E'Commercial Printing', E'Companies providing commercial printing services. Includes printers primarily serving the media industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20201050', E'Industrials', E'Commercial  & Professional Services', E'Commercial Services & Supplies', E'Environmental & Facilities Services', E'Companies providing environmental and facilities maintenance services. Includes waste management, facilities management and pollution control services.  Excludes large-scale water treatment systems classified in the Water Utilities Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20201060', E'Industrials', E'Commercial  & Professional Services', E'Commercial Services & Supplies', E'Office Services & Supplies', E'Providers of office services and manufacturers of office supplies and equipment not classified elsewhere.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20201070', E'Industrials', E'Commercial  & Professional Services', E'Commercial Services & Supplies', E'Diversified Support Services', E'Companies primarily providing labor oriented support services to businesses and governments.  Includes commercial cleaning services, dining & catering services, equipment repair services, industrial maintenance services, industrial auctioneers, storage & warehousing, transaction services, uniform rental services, and other business support services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20201080', E'Industrials', E'Commercial  & Professional Services', E'Commercial Services & Supplies', E'Security & Alarm Services', E'Companies providing security and protection services to business and governments. Includes companies providing services such as correctional facilities, security & alarm services, armored transportation & guarding.  Excludes companies providing security software classified under the Systems Software Sub-Industry and home security services classified under the Specialized Consumer Services Sub-Industry. Also excludes companies manufacturing security system equipment classified under the Electronic Equipment & Instruments Sub-Industry. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20202010', E'Industrials', E'Commercial  & Professional Services', E'Professional Services', E'Human Resource & Employment Services', E'Companies providing business support services relating to human capital management. Includes employment agencies, employee training, payroll & benefit support services, retirement support services and temporary agencies.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20202020', E'Industrials', E'Commercial  & Professional Services', E'Professional Services', E'Research & Consulting Services', E'Companies primarily providing research and consulting services to businesses and governments not classified elsewhere.  Includes companies involved in management consulting services, architectural design, business information or scientific research, marketing, and testing & certification services. Excludes companies providing information technology consulting services classified in the IT Consulting & Other Services Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20301010', E'Industrials', E'Transportation', E'Air Freight & Logistics', E'Air Freight & Logistics', E'Companies providing air freight transportation, courier and logistics services, including package and mail delivery and customs agents. Excludes those companies classified in the Airlines, Marine or Trucking Sub-Industries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20302010', E'Industrials', E'Transportation', E'Airlines', E'Airlines', E'Companies providing primarily passenger air transportation.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20303010', E'Industrials', E'Transportation', E'Marine', E'Marine', E'Companies providing goods or passenger maritime transportation. Excludes cruise-ships classified in the Hotels, Resorts & Cruise Lines Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20304010', E'Industrials', E'Transportation', E'Road & Rail', E'Railroads', E'Companies providing primarily goods and passenger rail  transportation.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20304020', E'Industrials', E'Transportation', E'Road & Rail', E'Trucking', E'Companies providing primarily goods and passenger land transportation. Includes vehicle rental and taxi companies.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20305010', E'Industrials', E'Transportation', E'Transportation Infrastructure', E'Airport Services', E'Operators of airports and companies providing related services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20305020', E'Industrials', E'Transportation', E'Transportation Infrastructure', E'Highways & Railtracks', E'Owners and operators of roads, tunnels and railtracks.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'20305030', E'Industrials', E'Transportation', E'Transportation Infrastructure', E'Marine Ports & Services', E'Owners and operators of marine ports and related services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25101010', E'Consumer Discretionary', E'Automobiles & Components', E'Auto Components', E'Auto Parts & Equipment', E'Manufacturers of parts and accessories for  automobiles and motorcycles. Excludes companies classified in the Tires & Rubber Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25101020', E'Consumer Discretionary', E'Automobiles & Components', E'Auto Components', E'Tires & Rubber', E'Manufacturers of tires and rubber.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25102010', E'Consumer Discretionary', E'Automobiles & Components', E'Automobiles', E'Automobile Manufacturers', E'Companies that produce mainly passenger automobiles and light trucks. Excludes companies producing mainly motorcycles and three-wheelers classified in the Motorcycle Manufacturers Sub-Industry and heavy duty trucks classified in the Construction Machinery & Heavy Trucks Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25102020', E'Consumer Discretionary', E'Automobiles & Components', E'Automobiles', E'Motorcycle Manufacturers', E'Companies that produce motorcycles, scooters or three-wheelers. Excludes bicycles classified in the Leisure Products Sub-Industry. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25201010', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Household Durables', E'Consumer Electronics', E'Manufacturers of consumer electronics products including TVs, home audio equipment, game consoles, digital cameras, and related products. Excludes personal home computer manufacturers classified in the Technology Hardware, Storage & Peripherals Sub-Industry, and electric household appliances classified in the Household Appliances Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25201020', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Household Durables', E'Home Furnishings', E'Manufacturers of soft home furnishings or furniture, including upholstery, carpets and wall-coverings.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25201030', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Household Durables', E'Homebuilding', E'Residential construction companies. Includes manufacturers of prefabricated houses and semi-fixed manufactured homes.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25201040', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Household Durables', E'Household Appliances', E'Manufacturers of electric household appliances and related products.  Includes manufacturers of power and hand tools, including garden improvement tools.  Excludes TVs and other audio and video products classified in the Consumer Electronics Sub-Industry and personal computers classified in the Technology Hardware, Storage & Peripherals Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25201050', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Household Durables', E'Housewares & Specialties', E'Manufacturers of durable household products, including cutlery, cookware, glassware, crystal, silverware, utensils, kitchenware and consumer specialties not classified elsewhere.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25202010', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Leisure Products', E'Leisure Products', E'Manufacturers of leisure products and equipment includingsports equipment, bicycles and toys.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25203010', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Textiles, Apparel & Luxury Goods', E'Apparel, Accessories & Luxury Goods', E'Manufacturers of apparel, accessories & luxury goods. Includes companies primarily producing designer handbags, wallets, luggage, jewelry and watches. Excludes shoes classified in the Footwear Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25203020', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Textiles, Apparel & Luxury Goods', E'Footwear', E'Manufacturers of footwear. Includes sport and leather shoes.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25203030', E'Consumer Discretionary', E'Consumer Durables & Apparel', E'Textiles, Apparel & Luxury Goods', E'Textiles', E'Manufacturers of textile and related products not classified in the Apparel, Accessories & Luxury Goods, Footwear or Home Furnishings Sub-Industries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25301010', E'Consumer Discretionary', E'Consumer Services', E'Hotels, Restaurants & Leisure', E'Casinos & Gaming', E'Owners and operators of casinos and gaming facilities. Includes companies providing lottery and betting services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25301020', E'Consumer Discretionary', E'Consumer Services', E'Hotels, Restaurants & Leisure', E'Hotels, Resorts & Cruise Lines', E'Owners and operators of hotels, resorts and cruise-ships. Includes travel agencies, tour operators and related services not classified elsewhere . Excludes casino-hotels classified in the Casinos & Gaming Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25301030', E'Consumer Discretionary', E'Consumer Services', E'Hotels, Restaurants & Leisure', E'Leisure Facilities', E'Owners and operators of leisure facilities, including sport and fitness centers, stadiums, golf courses and amusement parks not classified in the Movies & Entertainment Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25301040', E'Consumer Discretionary', E'Consumer Services', E'Hotels, Restaurants & Leisure', E'Restaurants', E'Owners and operators of restaurants, bars, pubs, fast-food or take-out facilities. Includes companies that provide food catering services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25302010', E'Consumer Discretionary', E'Consumer Services', E'Diversified Consumer Services', E'Education Services', E'Companies providing educational services, either on-line or through conventional teaching methods. Includes, private universities, correspondence teaching, providers of educational seminars, educational materials and technical education. Excludes companies providing employee education programs classified in the Human Resources & Employment Services Sub-Industry');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25302020', E'Consumer Discretionary', E'Consumer Services', E'Diversified Consumer Services', E'Specialized Consumer Services', E'Companies providing consumer services not classified elsewhere.  Includes residential services, home security, legal services, personal services, renovation & interior design services, consumer auctions and wedding & funeral services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25501010', E'Consumer Discretionary', E'Retailing', E'Distributors', E'Distributors', E'Distributors and wholesalers of general merchandise not classified elsewhere. Includes vehicle distributors.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25502020', E'Consumer Discretionary', E'Retailing', E'Internet & Direct Marketing Retail', E'Internet & Direct Marketing Retail', E'Companies  providing  retail  services  primarily  on  the Internet, through mail order, and TV home shopping retailers. Also includes companies providing online marketplaces for consumer products and services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25503010', E'Consumer Discretionary', E'Retailing', E'Multiline Retail', E'Department Stores', E'Owners and operators of department stores.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25503020', E'Consumer Discretionary', E'Retailing', E'Multiline Retail', E'General Merchandise Stores', E'Owners and operators of stores offering diversified general merchandise. Excludes hypermarkets and large-scale super centers classified in the Hypermarkets & Super Centers Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25504010', E'Consumer Discretionary', E'Retailing', E'Specialty Retail', E'Apparel Retail', E'Retailers specialized mainly in apparel and accessories.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25504020', E'Consumer Discretionary', E'Retailing', E'Specialty Retail', E'Computer &Electronics Retail', E'Owners and operators of consumer electronics, computers, video and related products retail stores.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25504030', E'Consumer Discretionary', E'Retailing', E'Specialty Retail', E'Home Improvement Retail', E'Owners and operators of home and garden improvement retail stores. Includes stores offering building materials and supplies.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25504040', E'Consumer Discretionary', E'Retailing', E'Specialty Retail', E'Specialty Stores', E'Owners and operators of specialty retail stores not classified elsewhere. Includes jewelry stores, toy stores, office supply stores, health & vision care stores, and book & entertainment stores.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25504050', E'Consumer Discretionary', E'Retailing', E'Specialty Retail', E'Automotive Retail', E'Ownersand operators of stores specializing in automotive retail.  Includes auto dealers, gas stations, and retailers of auto accessories, motorcycles & parts, automotive glass, and automotive equipment & parts.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'25504060', E'Consumer Discretionary', E'Retailing', E'Specialty Retail', E'Homefurnishing Retail', E'Owners and operators of furniture and home furnishings retail stores.  Includes residential furniture, homefurnishings, housewares, and interior design.  Excludes home and garden improvement stores, classified in the Home Improvement Retail Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30101010', E'Consumer Staples', E'Food & Staples Retailing', E'Food & Staples Retailing', E'Drug Retail', E'Owners and operators of primarily drug retail stores and pharmacies.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30101020', E'Consumer Staples', E'Food & Staples Retailing', E'Food & Staples Retailing', E'Food Distributors', E'Distributors of food products to other companies and not directly to the consumer.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30101030', E'Consumer Staples', E'Food & Staples Retailing', E'Food & Staples Retailing', E'Food Retail', E'Owners and operators of primarily food retail stores.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30101040', E'Consumer Staples', E'Food & Staples Retailing', E'Food & Staples Retailing', E'Hypermarkets & Super Centers', E'Owners and operators of hypermarkets and super centers selling food and a wide-range of consumer staple products.  Excludes Food and Drug Retailers classified in the Food Retail and Drug Retail Sub-Industries, respectively.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30201010', E'Consumer Staples', E'Food, Beverage & Tobacco', E'Beverages', E'Brewers', E'Producers of beer and malt liquors. Includes breweries not classified in the Restaurants Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30201020', E'Consumer Staples', E'Food, Beverage & Tobacco', E'Beverages', E'Distillers & Vintners', E'Distillers, vintners and producers of alcoholic beverages not classified in the Brewers Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30201030', E'Consumer Staples', E'Food, Beverage & Tobacco', E'Beverages', E'Soft Drinks', E'Producers of non-alcoholic beverages including mineral waters. Excludes producers of milk classified in the Packaged Foods Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30202010', E'Consumer Staples', E'Food, Beverage & Tobacco', E'Food Products', E'Agricultural Products', E'Producers of agricultural products. Includes crop growers, owners of plantations and companies that produce and process foods but do not package and market them. Excludescompanies classified in the Forest Products Sub-Industry and those that package and market the food products classified in the Packaged Foods Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30202030', E'Consumer Staples', E'Food, Beverage & Tobacco', E'Food Products', E'Packaged Foods & Meats', E'Producers of packaged foods including dairy products, fruit juices, meats, poultry, fish and pet foods.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30203010', E'Consumer Staples', E'Food, Beverage & Tobacco', E'Tobacco', E'Tobacco', E'Manufacturers of cigarettes and other tobacco products.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30301010', E'Consumer Staples', E'Household & Personal Products', E'Household Products', E'Household Products', E'Producers of non-durable household products, including detergents, soaps, diapers and other tissue and household paper products not classified in the Paper Products Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'30302010', E'Consumer Staples', E'Household & Personal Products', E'Personal Products', E'Personal Products', E'Manufacturers of personal and beauty care products, including cosmetics and perfumes.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35101010', E'Health Care', E'Health Care Equipment & Services', E'Health Care Equipment & Supplies', E'Health Care Equipment', E'Manufacturers of health care equipment and devices. Includes medical instruments, drug delivery systems, cardiovascular & orthopedic devices, and diagnostic equipment.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35101020', E'Health Care', E'Health Care Equipment & Services', E'Health Care Equipment & Supplies', E'Health Care Supplies', E'Manufacturers of health care supplies and medical products not classified elsewhere. Includes eye care products, hospital supplies, and safety needle & syringe devices.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35102010', E'Health Care', E'Health Care Equipment & Services', E'Health Care Providers & Services', E'Health Care Distributors', E'Distributors and wholesalers of health care products not classified elsewhere. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35102015', E'Health Care', E'Health Care Equipment & Services', E'Health Care Providers & Services', E'Health Care  Services', E'Providers of patient health care services not classified elsewhere. Includes dialysis centers, lab testing services, and pharmacy management services. Also includes companies providing business support services to health care providers, such as clerical support services, collection agency services, staffing services and outsourced sales & marketing services');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35102020', E'Health Care', E'Health Care Equipment & Services', E'Health Care Providers & Services', E'Health Care Facilities', E'Owners and operatorsof health care facilities, including hospitals, nursing homes, rehabilitation centers and animal hospitals.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35102030', E'Health Care', E'Health Care Equipment & Services', E'Health Care Providers & Services', E'Managed Health Care', E'Owners and operators of Health Maintenance Organizations (HMOs) and other managed plans.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35103010', E'Health Care', E'Health Care Equipment & Services', E'Health Care Technology', E'Health Care Technology', E'Companies providing information technology services primarily to health care providers.  Includes companies providing application, systems and/or data processing software, internet-based tools, and IT consulting services to doctors, hospitals or businesses operating primarily in the Health Care Sector');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35201010', E'Health Care', E'Pharmaceuticals, Biotechnology & Life Sciences', E'Biotechnology', E'Biotechnology', E'Companies primarily engaged in the research, development, manufacturing and/or marketing of products based on genetic analysis and genetic engineering.  Includes companies specializing in protein-based therapeutics to treat human diseases. Excludes companies manufacturing products using biotechnology but without a health care application.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35202010', E'Health Care', E'Pharmaceuticals, Biotechnology & Life Sciences', E'Pharmaceuticals', E'Pharmaceuticals', E'Companies engaged in the research, development or production of pharmaceuticals. Includes veterinary drugs.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'35203010', E'Health Care', E'Pharmaceuticals, Biotechnology & Life Sciences', E'Life Sciences Tools & Services', E'Life Sciences Tools & Services', E'Companies enabling the drug discovery, development and production continuum by providing analytical tools, instruments, consumables & supplies, clinical trial services and contract research services.  Includes firms primarily servicing the pharmaceutical and biotechnology industries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40101010', E'Financials', E'Banks', E'Banks', E'Diversified Banks', E'Large, geographically diverse banks with a national footprint whose revenues are derived primarily from conventional banking operations, have significant business activity in retail banking and small and medium corporate lending, and provide a diverse range of financial services.  Excludes banks classified in the Regional Banks and Thrifts & Mortgage Finance Sub-Industries. Also excludes investment banks classified in the Investment Banking & Brokerage Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40101015', E'Financials', E'Banks', E'Banks', E'Regional Banks', E'Commercial banks whose businesses are derived primarily from conventional banking operations and have significant business activity in retail banking and small and medium corporate lending. Regional banks tend to operate in limited geographic regions. Excludes companies classified in the Diversified Banks and Thrifts & Mortgage Banks sub-industries. Also excludes investment banks classified in the Investment Banking & Brokerage Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40102010', E'Financials', E'Banks', E'Thrifts & Mortgage Finance', E'Thrifts & Mortgage Finance', E'Financial institutions providing mortgage and mortgage related services.  These include financial institutions whose assets are primarily mortgage related, savings & loans, mortgage lending institutions, building societies and companies providing insurance to mortgage banks.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40201020', E'Financials', E'Diversified Financials', E'Diversified Financial Services', E'Other Diversified Financial Services', E'Providers of a diverse range of financial services and/or with some interest in a wide range of financial services including banking, insurance and capital markets, but with no dominant business line. Excludes companies classified in the Regional Banks and Diversified Banks Sub-Industries.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40201030', E'Financials', E'Diversified Financials', E'Diversified Financial Services', E'Multi-Sector Holdings', E'A company with significantly diversified holdings across three or more sectors, none of which contributes a majority of profit and/or sales. Stakes held are predominantly of a non-controlling nature.  Includes diversified financial companies where stakes held are of a controlling nature. Excludes other diversified companies classified in the Industrials Conglomerates Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40201040', E'Financials', E'Diversified Financials', E'Diversified Financial Services', E'Specialized Finance', E'Providers  of  specialized  financial  services  not  classified  elsewhere. Companies  in  this  sub-industry  derive  a  majority  of  revenue  from  one  specialized  line  of  business. Includes,  but  not  limited  to,  commercial  financing  companies,  central  banks,  leasing  institutions, factoring services, and specialty boutiques. Excludes companies classified in the Financial Exchanges & Data sub-industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40202010', E'Financials', E'Diversified Financials', E'Consumer Finance', E'Consumer Finance', E'Providers of consumer finance services, including personal credit, credit cards, lease financing, travel-related money services and pawn shops.  Excludes mortgage lenders classified in the Thrifts & Mortgage Finance Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40203010', E'Financials', E'Diversified Financials', E'Capital Markets', E'Asset Management & Custody Banks', E'Financial institutions primarily engaged in investment management and/or related custody and securities fee-based services. Includes companies operating mutual funds, closed-end funds and unit investment trusts.  Excludes banks and other financial institutions primarily involved in commercial lending, investment banking, brokerage and other specialized financial activities. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40203020', E'Financials', E'Diversified Financials', E'Capital Markets', E'Investment Banking & Brokerage', E'Financial institutions primarily engaged in investment banking & brokerage services, including equity and debt underwriting, mergers and acquisitions, securities lending and advisory services. Excludes banks and other financial institutions primarily involved in commercial lending, asset management and specialized financial activities. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40203030', E'Financials', E'Diversified Financials', E'Capital Markets', E'Diversified Capital Markets', E'Financial institutions primarily engaged in diversified capital markets activities, including a significant presence in at least two of the following area: large/major corporate lending, investment banking, brokerage and asset management. Excludes less diversified companies classified in the Asset Management& Custody Banks or Investment Banking & Brokerage sub-industries.  Also excludes companies classified in the Banks or Insurance industry groups or the Consumer Finance Sub-Industry. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40203040', E'Financials', E'Diversified Financials', E'Capital Markets', E'Financial Exchanges & Data', E'Financial  exchanges  for  securities,  commodities,  derivatives and other financial instruments, and providers of financial decision support tools and products  including ratings agencies');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40204010', E'Financials', E'Diversified Financials', E'Mortgage Real Estate Investment Trusts (REITs)', E'Mortgage REITs', E'Companies or Trusts that service, originate, purchase and/or securitize residential and/or commercial mortgage loans.  Includes trusts that invest in mortgage-backed securities and other mortgage related assets.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40301010', E'Financials', E'Insurance', E'Insurance', E'Insurance Brokers', E'Insurance and reinsurance brokerage firms.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40301020', E'Financials', E'Insurance', E'Insurance', E'Life & Health Insurance', E'Companies providing primarily life, disability, indemnity or supplemental health insurance. Excludes managed care companies classified in the Managed Health Care Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40301030', E'Financials', E'Insurance', E'Insurance', E'Multi-line Insurance', E'Insurance companies with diversified interests in life, health and property and casualty insurance.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40301040', E'Financials', E'Insurance', E'Insurance', E'Property & Casualty Insurance', E'Companies providing primarily property and casualty insurance.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'40301050', E'Financials', E'Insurance', E'Insurance', E'Reinsurance', E'Companies providing primarily reinsurance.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45102010', E'Information Technology', E'Software & Services', E'IT Services', E'IT Consulting & Other Services', E'Providers of information technology and systems integration services not classified in the Data Processing & Outsourced Services Sub-Industry.  Includes information technology consulting and information management services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45102020', E'Information Technology', E'Software & Services', E'IT Services', E'Data Processing & Outsourced Services', E'Providers of commercial electronic data processing and/or business process outsourcing services.  Includes companies that provide services for back-office automation.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45102030', E'Information Technology', E'Software & Services', E'IT Services', E'Internet Services & Infrastructure', E'Companies providing services and infrastructure for the internet industry including data centers and cloud networking and storage infrastructure. Also includes companies providing web hosting services. Excludes companies classified in the Software Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45103010', E'Information Technology', E'Software & Services', E'Software', E'Application Software', E'Companies engaged in developing and producing software designed for specialized applications for the business or consumer market. Includes enterprise and technical software, as well as cloud-based software. Excludes companies classified in the Interactive Home Entertainment Sub-Industry. Also excludes companies producing systems or database management software classified in the Systems Software Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45103020', E'Information Technology', E'Software & Services', E'Software', E'Systems Software', E'Companies engaged in developing and producing systems and database management software.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45201020', E'Information Technology', E'Technology Hardware & Equipment', E'Communications Equipment', E'Communications Equipment', E'Manufacturers of communication equipment and products, including LANs, WANs, routers, telephones, switchboards and exchanges. Excludes cellular phone manufacturers classified in the Technology Hardware,Storage & Peripherals Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45202030', E'Information Technology', E'Technology Hardware & Equipment', E'Technology Hardware, Storage & Peripherals', E'Technology Hardware, Storage & Peripherals', E'Manufacturers of cellular phones, personal computers, servers, electronic computer components and peripherals. Includes data storage components, motherboards, audio and video cards, monitors, keyboards, printers, and other peripherals. Excludes semiconductors classified in the Semiconductors Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45203010', E'Information Technology', E'Technology Hardware & Equipment', E'Electronic Equipment, Instruments & Components', E'Electronic Equipment & Instruments ', E'Manufacturers of electronic equipment and instruments including analytical, electronic test and measurement instruments, scanner/barcode products, lasers, display screens, point-of-sales machines, and security system equipment.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45203015', E'Information Technology', E'Technology Hardware & Equipment', E'Electronic Equipment, Instruments & Components', E'Electronic Components', E'Manufacturers of electronic components. Includes electronic components, connection devices, electron tubes, electronic capacitors and resistors, electronic coil, printed circuit board, transformer and other inductors, signal processing technology/components.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45203020', E'Information Technology', E'Technology Hardware & Equipment', E'Electronic Equipment, Instruments & Components', E'Electronic Manufacturing Services', E'Producers of electronic equipment mainly for the OEM (Original Equipment Manufacturers) markets.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45203030', E'Information Technology', E'Technology Hardware & Equipment', E'Electronic Equipment, Instruments & Components', E'Technology Distributors', E'Distributors of technology hardware and equipment. Includes distributors of communications equipment, computers & peripherals, semiconductors, and electronic equipment and components.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45301010', E'Information Technology', E'Semiconductors & Semiconductor Equipment', E'Semiconductors & Semiconductor Equipment', E'Semiconductor Equipment ', E'Manufacturers of semiconductor equipment, including manufacturers of the raw material and equipment used in the solar power industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'45301020', E'Information Technology', E'Semiconductors & Semiconductor Equipment', E'Semiconductors & Semiconductor Equipment', E'Semiconductors', E'Manufacturers of semiconductors and related products, including manufacturers of solar modules and cells.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50101010', E'Communication Services', E'Telecommunication Services', E'Diversified Telecommunication Services', E'Alternative Carriers', E'Providers of communications and high-density data transmission services primarily through a high bandwidth/fiber-optic cable network.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50101020', E'Communication Services', E'Telecommunication Services', E'Diversified Telecommunication Services', E'Integrated Telecommunication Services', E'Operators of primarily fixed-line telecommunications networks and companies providing both wireless and fixed-line telecommunicationsservices not classified elsewhere. Also includes internet service providers offering internet access to end users.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50102010', E'Communication Services', E'Telecommunication Services', E'Wireless Telecommunication Services', E'Wireless Telecommunication Services', E'Providers of primarily cellular or wireless telecommunication services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50201010', E'Communication Services', E'Media & Entertainment', E'Media', E'Advertising', E'Companies providing advertising, marketing or public relations services.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50201020', E'Communication Services', E'Media & Entertainment', E'Media', E'Broadcasting', E'Owners and operators of television or radio broadcasting systems, including programming. Includes radio and television broadcasting, radio networks, and radio stations.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50201030', E'Communication Services', E'Media & Entertainment', E'Media', E'Cable &Satellite', E'Providers of cable or satellite television services. Includes cable networks and program distribution.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50201040', E'Communication Services', E'Media & Entertainment', E'Media', E'Publishing', E'Publishers of newspapers, magazines and books in print or electronic formats.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50202010', E'Communication Services', E'Media & Entertainment', E'Entertainment', E'Movies & Entertainment', E'Companies that engage in producing and selling entertainment products and services, including companies engaged in the production, distribution and screening of movies and television shows, producers and distributors of music, entertainment theaters and sports teams. Also includes companies offering and/or producing entertainment content streamed online.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50202020', E'Communication Services', E'Media & Entertainment', E'Entertainment', E'Interactive Home Entertainment', E'Producers of interactive gaming products, including mobile gaming applications. Also includes educational software used primarily in the home. Excludes online gambling companies classified in the Casinos & Gaming Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'50203010', E'Communication Services', E'Media & Entertainment', E'Interactive Media & Services', E'Interactive Media & Services', E'Companies engaging in content and information creation or distribution through proprietary platforms, where revenues are derived primarily through pay-per-click advertisements. Includes search engines, social media and networking platforms, online classifieds, and online review companies. Excludes companies operating online marketplaces classified in Internet & Direct Marketing Retail. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'55101010', E'Utilities', E'Utilities', E'Electric Utilities', E'Electric Utilities', E'Companies that produce or distribute electricity. Includes both nuclear and non-nuclear facilities.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'55102010', E'Utilities', E'Utilities', E'Gas Utilities', E'Gas Utilities', E'Companies whose main charter is to distribute and transmit natural and manufactured gas. Excludes companies primarily involved in gas exploration or production classified in the Oil & Gas Exploration & Production Sub-Industry. Also excludes companies engaged in thestorage and/or transportation of oil, gas, and/or refined products classified in the Oil & Gas Storage & Transportation Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'55103010', E'Utilities', E'Utilities', E'Multi-Utilities', E'Multi-Utilities', E'Utility companies with significantly diversified activities in addition to core Electric Utility, Gas Utility and/or Water Utility operations.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'55104010', E'Utilities', E'Utilities', E'Water Utilities', E'Water Utilities', E'Companies that purchase and redistribute water to the end-consumer. Includes large-scale water treatment systems.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'55105010', E'Utilities', E'Utilities', E'Independent Power and Renewable Electricity Producers', E'Independent Power Producers & Energy Traders', E'Companies that operate as Independent Power Producers (IPPs), Gas & Power Marketing & Trading Specialists and/or Integrated Energy Merchants. Excludes producers of electricity using renewable sources, such as solar power, hydropower, and wind power. Also excludes electric transmission companies and utility distribution companies classified in the Electric Utilities Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'55105020', E'Utilities', E'Utilities', E'Independent Power and Renewable Electricity Producers', E'Renewable Electricity ', E'Companies that engage in the generation and distribution of electricity using renewable sources, including, but not limited to, companies that produce electricity using biomass, geothermal energy, solar energy, hydropower, and wind power. Excludes companies manufacturing capital equipment used to generate electricity using renewable sources, such as manufacturers of solar power systems, installers of photovoltaic cells,  and companies involved in the provision of technology, components, and services mainly to this market. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60101010', E'Real Estate', E'Real Estate', E'Diversified REITs', E'Diversified REITs', E'A company or Trust with significantly diversified operations across two or more property types.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60101020', E'Real Estate', E'Real Estate', E'Diversified REITs', E'Industrial REITs', E'Companies or Trusts engaged in the acquisition, development, ownership, leasing, management and operation of industrial properties. Includescompanies operating industrial warehouses and distribution properties.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60101030', E'Real Estate', E'Real Estate', E'Diversified REITs', E'Hotel & Resort REITs ', E'Companies or Trusts engaged in the acquisition, development, ownership, leasing, management and operation of hotel and resort properties. ');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60101040', E'Real Estate', E'Real Estate', E'Diversified REITs', E'Office REITs ', E'Companies or Trusts engaged in the acquisition, development, ownership, leasing, management and operation of office properties.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60101050', E'Real Estate', E'Real Estate', E'Diversified REITs', E'Health Care REITs ', E'Companies or Trusts engaged in the acquisition, development, ownership, leasing, management and operation of properties serving the health care industry, including hospitals, nursing homes, and assisted living properties.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60101060', E'Real Estate', E'Real Estate', E'Diversified REITs', E'Residential REITs', E'Companies or Trusts engaged in the acquisition, development, ownership, leasing, management and operation of residential properties including multifamily homes, apartments, manufactured homes and student housing properties');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60101070', E'Real Estate', E'Real Estate', E'Diversified REITs', E'Retail REITs', E'Companies or Trusts engaged in the acquisition, development, ownership, leasing, management and operation of shopping malls, outlet malls, neighborhood and community shopping centers.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60101080', E'Real Estate', E'Real Estate', E'Diversified REITs', E'Specialized REITs ', E'Companies or Trusts engaged in the acquisition, development, ownership, leasing, management and operation of properties not classified elsewhere. Includes trusts that operate and invest in storage properties. It also includes REITs that do not generate a majority of their revenues and income from real estate rental and leasing operations.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60102010', E'Real Estate', E'Real Estate', E'Real Estate Management & Development', E'Diversified Real Estate Activities ', E'Companies engaged in a diverse spectrum of real estate activities including real estate development & sales, real estate management, or real estate services, but with no dominant business line.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60102020', E'Real Estate', E'Real Estate', E'Real Estate Management & Development', E'Real Estate Operating Companies', E'Companies engaged in operating real estate properties for the purpose of leasing & management.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60102030', E'Real Estate', E'Real Estate', E'Real Estate Management & Development', E'Real Estate Development ', E'Companies that develop real estate and sell the properties after development. Excludes companies classified in the Homebuilding Sub-Industry.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60102040', E'Real Estate', E'Real Estate', E'Real Estate Management & Development', E'Real Estate Services ', E'Real estate service providers such as real estate agents, brokers & real estate appraisers.');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60102510', E'Real Estate', E'Real Estate', E'Industrial REITs', E'Industrial REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60103010', E'Real Estate', E'Real Estate', E'Hotel & Resort REITs', E'Hotel & Resort REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60104010', E'Real Estate', E'Real Estate', E'Office REITs', E'Office REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60105010', E'Real Estate', E'Real Estate', E'Health Care REITs', E'Health Care REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60106010', E'Real Estate', E'Real Estate', E'Residential REITs', E'Multi-Family Residential REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60106020', E'Real Estate', E'Real Estate', E'Residential REITs', E'Single-Family Residential REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60107010', E'Real Estate', E'Real Estate', E'Retail REITs', E'Retail REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60108010', E'Real Estate', E'Real Estate', E'Specialized REITs', E'Other Specialized REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60108020', E'Real Estate', E'Real Estate', E'Specialized REITs', E'Self-Storage REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60108030', E'Real Estate', E'Real Estate', E'Specialized REITs', E'Telecom Tower REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60108040', E'Real Estate', E'Real Estate', E'Specialized REITs', E'Timber REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60108050', E'Real Estate', E'Real Estate', E'Specialized REITs', E'Data Center REITs', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60201010', E'Real Estate', E'Real Estate Management & Development', E'Real Estate Management & Development', E'Diversified Real Estate Activities', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60201020', E'Real Estate', E'Real Estate Management & Development', E'Real Estate Management & Development', E'Real Estate Operating Companies', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60201030', E'Real Estate', E'Real Estate Management & Development', E'Real Estate Management & Development', E'Real Estate Development', E'null');
-- ddl-end --
INSERT INTO public.gics_codes (id, sector, industry_group, industry, sub_industry, description) VALUES (E'60201040', E'Real Estate', E'Real Estate Management & Development', E'Real Estate Management & Development', E'Real Estate Services', E'null');
-- ddl-end --

-- object: public.countries | type: TABLE --
-- DROP TABLE IF EXISTS public.countries CASCADE;
CREATE TABLE public.countries (
	id bigint NOT NULL,
	name text NOT NULL,
	name_prefix text,
	alpha2_code text,
	alpha3_code text NOT NULL,
	numeric_code text,
	CONSTRAINT countries_id_pk PRIMARY KEY (id),
	CONSTRAINT countries_alpha3_code_uq UNIQUE (alpha3_code),
	CONSTRAINT countries_numeric_code_uq UNIQUE (numeric_code)
);
-- ddl-end --
COMMENT ON COLUMN public.countries.alpha2_code IS E'ISO-3166 Alpha 2';
-- ddl-end --
COMMENT ON COLUMN public.countries.alpha3_code IS E'ISO-3166 Alpha 3';
-- ddl-end --
COMMENT ON COLUMN public.countries.numeric_code IS E'ISO-3166 Numeric';
-- ddl-end --
ALTER TABLE public.countries OWNER TO postgres;
-- ddl-end --

INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'1', E'Afghanistan', DEFAULT, E'AF', E'AFG', E'004');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'2', E'Åland Islands', DEFAULT, E'AX', E'ALA', E'248');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'3', E'Albania', DEFAULT, E'AL', E'ALB', E'008');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'4', E'Algeria', DEFAULT, E'DZ', E'DZA', E'012');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'5', E'American Samoa', DEFAULT, E'AS', E'ASM', E'016');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'6', E'Andorra', DEFAULT, E'AD', E'AND', E'020');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'7', E'Angola', DEFAULT, E'AO', E'AGO', E'024');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'8', E'Anguilla', DEFAULT, E'AI', E'AIA', E'660');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'9', E'Antarctica', DEFAULT, E'AQ', E'ATA', E'010');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'10', E'Antigua and Barbuda', DEFAULT, E'AG', E'ATG', E'028');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'11', E'Argentina', DEFAULT, E'AR', E'ARG', E'032');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'12', E'Armenia', DEFAULT, E'AM', E'ARM', E'051');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'13', E'Aruba', DEFAULT, E'AW', E'ABW', E'533');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'14', E'Australia', DEFAULT, E'AU', E'AUS', E'036');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'15', E'Austria', DEFAULT, E'AT', E'AUT', E'040');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'16', E'Azerbaijan', DEFAULT, E'AZ', E'AZE', E'031');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'17', E'Bahamas', DEFAULT, E'BS', E'BHS', E'044');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'18', E'Bahrain', DEFAULT, E'BH', E'BHR', E'048');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'19', E'Bangladesh', DEFAULT, E'BD', E'BGD', E'050');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'20', E'Barbados', DEFAULT, E'BB', E'BRB', E'052');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'21', E'Belarus', DEFAULT, E'BY', E'BLR', E'112');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'22', E'Belgium', DEFAULT, E'BE', E'BEL', E'056');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'23', E'Belize', DEFAULT, E'BZ', E'BLZ', E'084');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'24', E'Benin', DEFAULT, E'BJ', E'BEN', E'204');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'25', E'Bermuda', DEFAULT, E'BM', E'BMU', E'060');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'26', E'Bhutan', DEFAULT, E'BT', E'BTN', E'064');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'27', E'Bolivia', E'Plurinational State of', E'BO', E'BOL', E'068');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'28', E'Bonaire', E'Sint Eustatius and Saba', E'BQ', E'BES', E'535');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'29', E'Bosnia and Herzegovina', DEFAULT, E'BA', E'BIH', E'070');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'30', E'Botswana', DEFAULT, E'BW', E'BWA', E'072');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'31', E'Bouvet Island', DEFAULT, E'BV', E'BVT', E'074');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'32', E'Brazil', DEFAULT, E'BR', E'BRA', E'076');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'33', E'British Indian Ocean Territory', DEFAULT, E'IO', E'IOT', E'086');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'34', E'Brunei Darussalam', DEFAULT, E'BN', E'BRN', E'096');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'35', E'Bulgaria', DEFAULT, E'BG', E'BGR', E'100');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'36', E'Burkina Faso', DEFAULT, E'BF', E'BFA', E'854');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'37', E'Burundi', DEFAULT, E'BI', E'BDI', E'108');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'38', E'Cabo Verde', DEFAULT, E'CV', E'CPV', E'132');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'39', E'Cambodia', DEFAULT, E'KH', E'KHM', E'116');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'40', E'Cameroon', DEFAULT, E'CM', E'CMR', E'120');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'41', E'Canada', DEFAULT, E'CA', E'CAN', E'124');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'42', E'Cayman Islands', DEFAULT, E'KY', E'CYM', E'136');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'43', E'Central African Republic', DEFAULT, E'CF', E'CAF', E'140');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'44', E'Chad', DEFAULT, E'TD', E'TCD', E'148');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'45', E'Chile', DEFAULT, E'CL', E'CHL', E'152');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'46', E'China', DEFAULT, E'CN', E'CHN', E'156');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'47', E'Christmas Island', DEFAULT, E'CX', E'CXR', E'162');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'48', E'Cocos (Keeling) Islands', DEFAULT, E'CC', E'CCK', E'166');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'49', E'Colombia', DEFAULT, E'CO', E'COL', E'170');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'50', E'Comoros', DEFAULT, E'KM', E'COM', E'174');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'51', E'Congo', DEFAULT, E'CG', E'COG', E'178');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'52', E'Congo', E' Democratic Republic of the', E'CD', E'COD', E'180');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'53', E'Cook Islands', DEFAULT, E'CK', E'COK', E'184');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'54', E'Costa Rica', DEFAULT, E'CR', E'CRI', E'188');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'55', E'Côte d''Ivoire', DEFAULT, E'CI', E'CIV', E'384');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'56', E'Croatia', DEFAULT, E'HR', E'HRV', E'191');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'57', E'Cuba', DEFAULT, E'CU', E'CUB', E'192');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'58', E'Curaçao', DEFAULT, E'CW', E'CUW', E'531');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'59', E'Cyprus', DEFAULT, E'CY', E'CYP', E'196');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'60', E'Czechia', DEFAULT, E'CZ', E'CZE', E'203');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'61', E'Denmark', DEFAULT, E'DK', E'DNK', E'208');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'62', E'Djibouti', DEFAULT, E'DJ', E'DJI', E'262');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'63', E'Dominica', DEFAULT, E'DM', E'DMA', E'212');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'64', E'Dominican Republic', DEFAULT, E'DO', E'DOM', E'214');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'65', E'Ecuador', DEFAULT, E'EC', E'ECU', E'218');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'66', E'Egypt', DEFAULT, E'EG', E'EGY', E'818');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'67', E'El Salvador', DEFAULT, E'SV', E'SLV', E'222');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'68', E'Equatorial Guinea', DEFAULT, E'GQ', E'GNQ', E'226');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'69', E'Eritrea', DEFAULT, E'ER', E'ERI', E'232');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'70', E'Estonia', DEFAULT, E'EE', E'EST', E'233');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'71', E'Eswatini', DEFAULT, E'SZ', E'SWZ', E'748');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'72', E'Ethiopia', DEFAULT, E'ET', E'ETH', E'231');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'73', E'Falkland Islands (Malvinas)', DEFAULT, E'FK', E'FLK', E'238');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'74', E'Faroe Islands', DEFAULT, E'FO', E'FRO', E'234');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'75', E'Fiji', DEFAULT, E'FJ', E'FJI', E'242');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'76', E'Finland', DEFAULT, E'FI', E'FIN', E'246');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'77', E'France', DEFAULT, E'FR', E'FRA', E'250');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'78', E'French Guiana', DEFAULT, E'GF', E'GUF', E'254');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'79', E'French Polynesia', DEFAULT, E'PF', E'PYF', E'258');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'80', E'French Southern Territories', DEFAULT, E'TF', E'ATF', E'260');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'81', E'Gabon', DEFAULT, E'GA', E'GAB', E'266');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'82', E'Gambia', DEFAULT, E'GM', E'GMB', E'270');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'83', E'Georgia', DEFAULT, E'GE', E'GEO', E'268');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'84', E'Germany', DEFAULT, E'DE', E'DEU', E'276');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'85', E'Ghana', DEFAULT, E'GH', E'GHA', E'288');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'86', E'Gibraltar', DEFAULT, E'GI', E'GIB', E'292');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'87', E'Greece', DEFAULT, E'GR', E'GRC', E'300');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'88', E'Greenland', DEFAULT, E'GL', E'GRL', E'304');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'89', E'Grenada', DEFAULT, E'GD', E'GRD', E'308');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'90', E'Guadeloupe', DEFAULT, E'GP', E'GLP', E'312');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'91', E'Guam', DEFAULT, E'GU', E'GUM', E'316');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'92', E'Guatemala', DEFAULT, E'GT', E'GTM', E'320');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'93', E'Guernsey', DEFAULT, E'GG', E'GGY', E'831');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'94', E'Guinea', DEFAULT, E'GN', E'GIN', E'324');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'95', E'Guinea-Bissau', DEFAULT, E'GW', E'GNB', E'624');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'96', E'Guyana', DEFAULT, E'GY', E'GUY', E'328');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'97', E'Haiti', DEFAULT, E'HT', E'HTI', E'332');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'98', E'Heard Island and McDonald Islands', DEFAULT, E'HM', E'HMD', E'334');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'99', E'Holy See', DEFAULT, E'VA', E'VAT', E'336');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'100', E'Honduras', DEFAULT, E'HN', E'HND', E'340');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'101', E'Hong Kong', DEFAULT, E'HK', E'HKG', E'344');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'102', E'Hungary', DEFAULT, E'HU', E'HUN', E'348');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'103', E'Iceland', DEFAULT, E'IS', E'ISL', E'352');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'104', E'India', DEFAULT, E'IN', E'IND', E'356');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'105', E'Indonesia', DEFAULT, E'ID', E'IDN', E'360');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'106', E'Iran', E'Islamic Republic of', E'IR', E'IRN', E'364');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'107', E'Iraq', DEFAULT, E'IQ', E'IRQ', E'368');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'108', E'Ireland', DEFAULT, E'IE', E'IRL', E'372');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'109', E'Isle of Man', DEFAULT, E'IM', E'IMN', E'833');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'110', E'Israel', DEFAULT, E'IL', E'ISR', E'376');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'111', E'Italy', DEFAULT, E'IT', E'ITA', E'380');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'112', E'Jamaica', DEFAULT, E'JM', E'JAM', E'388');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'113', E'Japan', DEFAULT, E'JP', E'JPN', E'392');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'114', E'Jersey', DEFAULT, E'JE', E'JEY', E'832');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'115', E'Jordan', DEFAULT, E'JO', E'JOR', E'400');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'116', E'Kazakhstan', DEFAULT, E'KZ', E'KAZ', E'398');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'117', E'Kenya', DEFAULT, E'KE', E'KEN', E'404');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'118', E'Kiribati', DEFAULT, E'KI', E'KIR', E'296');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'119', E'Korea', E'Democratic People''s Republic of', E'KP', E'PRK', E'408');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'120', E'Korea', E'Republic of', E'KR', E'KOR', E'410');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'121', E'Kuwait', DEFAULT, E'KW', E'KWT', E'414');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'122', E'Kyrgyzstan', DEFAULT, E'KG', E'KGZ', E'417');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'123', E'Lao People''s Democratic Republic', DEFAULT, E'LA', E'LAO', E'418');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'124', E'Latvia', DEFAULT, E'LV', E'LVA', E'428');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'125', E'Lebanon', DEFAULT, E'LB', E'LBN', E'422');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'126', E'Lesotho', DEFAULT, E'LS', E'LSO', E'426');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'127', E'Liberia', DEFAULT, E'LR', E'LBR', E'430');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'128', E'Libya', DEFAULT, E'LY', E'LBY', E'434');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'129', E'Liechtenstein', DEFAULT, E'LI', E'LIE', E'438');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'130', E'Lithuania', DEFAULT, E'LT', E'LTU', E'440');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'131', E'Luxembourg', DEFAULT, E'LU', E'LUX', E'442');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'132', E'Macao', DEFAULT, E'MO', E'MAC', E'446');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'133', E'Madagascar', DEFAULT, E'MG', E'MDG', E'450');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'134', E'Malawi', DEFAULT, E'MW', E'MWI', E'454');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'135', E'Malaysia', DEFAULT, E'MY', E'MYS', E'458');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'136', E'Maldives', DEFAULT, E'MV', E'MDV', E'462');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'137', E'Mali', DEFAULT, E'ML', E'MLI', E'466');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'138', E'Malta', DEFAULT, E'MT', E'MLT', E'470');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'139', E'Marshall Islands', DEFAULT, E'MH', E'MHL', E'584');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'140', E'Martinique', DEFAULT, E'MQ', E'MTQ', E'474');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'141', E'Mauritania', DEFAULT, E'MR', E'MRT', E'478');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'142', E'Mauritius', DEFAULT, E'MU', E'MUS', E'480');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'143', E'Mayotte', DEFAULT, E'YT', E'MYT', E'175');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'144', E'Mexico', DEFAULT, E'MX', E'MEX', E'484');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'145', E'Micronesia', E'Federated States of', E'FM', E'FSM', E'583');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'146', E'Moldova', E'Republic of', E'MD', E'MDA', E'498');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'147', E'Monaco', DEFAULT, E'MC', E'MCO', E'492');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'148', E'Mongolia', DEFAULT, E'MN', E'MNG', E'496');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'149', E'Montenegro', DEFAULT, E'ME', E'MNE', E'499');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'150', E'Montserrat', DEFAULT, E'MS', E'MSR', E'500');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'151', E'Morocco', DEFAULT, E'MA', E'MAR', E'504');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'152', E'Mozambique', DEFAULT, E'MZ', E'MOZ', E'508');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'153', E'Myanmar', DEFAULT, E'MM', E'MMR', E'104');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'154', E'Namibia', DEFAULT, E'NA', E'NAM', E'516');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'155', E'Nauru', DEFAULT, E'NR', E'NRU', E'520');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'156', E'Nepal', DEFAULT, E'NP', E'NPL', E'524');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'157', E'Netherlands', E'Kingdom of the', E'NL', E'NLD', E'528');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'158', E'New Caledonia', DEFAULT, E'NC', E'NCL', E'540');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'159', E'New Zealand', DEFAULT, E'NZ', E'NZL', E'554');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'160', E'Nicaragua', DEFAULT, E'NI', E'NIC', E'558');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'161', E'Niger', DEFAULT, E'NE', E'NER', E'562');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'162', E'Nigeria', DEFAULT, E'NG', E'NGA', E'566');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'163', E'Niue', DEFAULT, E'NU', E'NIU', E'570');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'164', E'Norfolk Island', DEFAULT, E'NF', E'NFK', E'574');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'165', E'North Macedonia', DEFAULT, E'MK', E'MKD', E'807');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'166', E'Northern Mariana Islands', DEFAULT, E'MP', E'MNP', E'580');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'167', E'Norway', DEFAULT, E'NO', E'NOR', E'578');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'168', E'Oman', DEFAULT, E'OM', E'OMN', E'512');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'169', E'Pakistan', DEFAULT, E'PK', E'PAK', E'586');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'170', E'Palau', DEFAULT, E'PW', E'PLW', E'585');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'171', E'Palestine', E'State of', E'PS', E'PSE', E'275');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'172', E'Panama', DEFAULT, E'PA', E'PAN', E'591');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'173', E'Papua New Guinea', DEFAULT, E'PG', E'PNG', E'598');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'174', E'Paraguay', DEFAULT, E'PY', E'PRY', E'600');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'175', E'Peru', DEFAULT, E'PE', E'PER', E'604');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'176', E'Philippines', DEFAULT, E'PH', E'PHL', E'608');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'177', E'Pitcairn', DEFAULT, E'PN', E'PCN', E'612');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'178', E'Poland', DEFAULT, E'PL', E'POL', E'616');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'179', E'Portugal', DEFAULT, E'PT', E'PRT', E'620');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'180', E'Puerto Rico', DEFAULT, E'PR', E'PRI', E'630');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'181', E'Qatar', DEFAULT, E'QA', E'QAT', E'634');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'182', E'Réunion', DEFAULT, E'RE', E'REU', E'638');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'183', E'Romania', DEFAULT, E'RO', E'ROU', E'642');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'184', E'Russian Federation', DEFAULT, E'RU', E'RUS', E'643');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'185', E'Rwanda', DEFAULT, E'RW', E'RWA', E'646');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'186', E'Saint Barthélemy', DEFAULT, E'BL', E'BLM', E'652');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'187', E'Saint Helena', E'Ascension and Tristan da Cunha', E'SH', E'SHN', E'654');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'188', E'Saint Kitts and Nevis', DEFAULT, E'KN', E'KNA', E'659');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'189', E'Saint Lucia', DEFAULT, E'LC', E'LCA', E'662');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'190', E'Saint Martin (French part)', DEFAULT, E'MF', E'MAF', E'663');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'191', E'Saint Pierre and Miquelon', DEFAULT, E'PM', E'SPM', E'666');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'192', E'Saint Vincent and the Grenadines', DEFAULT, E'VC', E'VCT', E'670');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'193', E'Samoa', DEFAULT, E'WS', E'WSM', E'882');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'194', E'San Marino', DEFAULT, E'SM', E'SMR', E'674');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'195', E'Sao Tome and Principe', DEFAULT, E'ST', E'STP', E'678');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'196', E'Saudi Arabia', DEFAULT, E'SA', E'SAU', E'682');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'197', E'Senegal', DEFAULT, E'SN', E'SEN', E'686');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'198', E'Serbia', DEFAULT, E'RS', E'SRB', E'688');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'199', E'Seychelles', DEFAULT, E'SC', E'SYC', E'690');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'200', E'Sierra Leone', DEFAULT, E'SL', E'SLE', E'694');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'201', E'Singapore', DEFAULT, E'SG', E'SGP', E'702');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'202', E'Sint Maarten (Dutch part)', DEFAULT, E'SX', E'SXM', E'534');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'203', E'Slovakia', DEFAULT, E'SK', E'SVK', E'703');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'204', E'Slovenia', DEFAULT, E'SI', E'SVN', E'705');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'205', E'Solomon Islands', DEFAULT, E'SB', E'SLB', E'090');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'206', E'Somalia', DEFAULT, E'SO', E'SOM', E'706');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'207', E'South Africa', DEFAULT, E'ZA', E'ZAF', E'710');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'208', E'South Georgia and the South Sandwich Islands', DEFAULT, E'GS', E'SGS', E'239');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'209', E'South Sudan', DEFAULT, E'SS', E'SSD', E'728');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'210', E'Spain', DEFAULT, E'ES', E'ESP', E'724');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'211', E'Sri Lanka', DEFAULT, E'LK', E'LKA', E'144');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'212', E'Sudan', DEFAULT, E'SD', E'SDN', E'729');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'213', E'Suriname', DEFAULT, E'SR', E'SUR', E'740');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'214', E'Svalbard and Jan Mayen', DEFAULT, E'SJ', E'SJM', E'744');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'215', E'Sweden', DEFAULT, E'SE', E'SWE', E'752');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'216', E'Switzerland', DEFAULT, E'CH', E'CHE', E'756');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'217', E'Syrian Arab Republic', DEFAULT, E'SY', E'SYR', E'760');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'218', E'Taiwan', E'Province of China', E'TW', E'TWN', E'158');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'219', E'Tajikistan', DEFAULT, E'TJ', E'TJK', E'762');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'220', E'Tanzania', E'United Republic of', E'TZ', E'TZA', E'834');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'221', E'Thailand', DEFAULT, E'TH', E'THA', E'764');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'222', E'Timor-Leste', DEFAULT, E'TL', E'TLS', E'626');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'223', E'Togo', DEFAULT, E'TG', E'TGO', E'768');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'224', E'Tokelau', DEFAULT, E'TK', E'TKL', E'772');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'225', E'Tonga', DEFAULT, E'TO', E'TON', E'776');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'226', E'Trinidad and Tobago', DEFAULT, E'TT', E'TTO', E'780');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'227', E'Tunisia', DEFAULT, E'TN', E'TUN', E'788');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'228', E'Türkiye', DEFAULT, E'TR', E'TUR', E'792');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'229', E'Turkmenistan', DEFAULT, E'TM', E'TKM', E'795');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'230', E'Turks and Caicos Islands', DEFAULT, E'TC', E'TCA', E'796');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'231', E'Tuvalu', DEFAULT, E'TV', E'TUV', E'798');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'232', E'Uganda', DEFAULT, E'UG', E'UGA', E'800');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'233', E'Ukraine', DEFAULT, E'UA', E'UKR', E'804');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'234', E'United Arab Emirates', DEFAULT, E'AE', E'ARE', E'784');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'235', E'United Kingdom of Great Britain and Northern Ireland', DEFAULT, E'GB', E'GBR', E'826');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'236', E'United States Minor Outlying Islands', DEFAULT, E'UM', E'UMI', E'581');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'237', E'United States of America', DEFAULT, E'US', E'USA', E'840');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'238', E'Uruguay', DEFAULT, E'UY', E'URY', E'858');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'239', E'Uzbekistan', DEFAULT, E'UZ', E'UZB', E'860');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'240', E'Vanuatu', DEFAULT, E'VU', E'VUT', E'548');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'241', E'Venezuela', E'Bolivarian Republic of', E'VE', E'VEN', E'862');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'242', E'Viet Nam', DEFAULT, E'VN', E'VNM', E'704');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'243', E'Virgin Islands (British)', DEFAULT, E'VG', E'VGB', E'092');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'244', E'Virgin Islands (U.S.)', DEFAULT, E'VI', E'VIR', E'850');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'245', E'Wallis and Futuna', DEFAULT, E'WF', E'WLF', E'876');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'246', E'Western Sahara', DEFAULT, E'EH', E'ESH', E'732');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'247', E'Yemen', DEFAULT, E'YE', E'YEM', E'887');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'248', E'Zambia', DEFAULT, E'ZM', E'ZMB', E'894');
-- ddl-end --
INSERT INTO public.countries (id, name, name_prefix, alpha2_code, alpha3_code, numeric_code) VALUES (E'249', E'Zimbabwe', DEFAULT, E'ZW', E'ZWE', E'716');
-- ddl-end --

-- object: public.indicators | type: TABLE --
-- DROP TABLE IF EXISTS public.indicators CASCADE;
CREATE TABLE public.indicators (
	security bigserial NOT NULL,
	date date NOT NULL,
	CONSTRAINT indicators_security_date_uq UNIQUE (security,date)
);
-- ddl-end --
COMMENT ON TABLE public.indicators IS E'Calculated indicators for securities.';
-- ddl-end --
ALTER TABLE public.indicators OWNER TO postgres;
-- ddl-end --

-- object: public.forex_indicators | type: TABLE --
-- DROP TABLE IF EXISTS public.forex_indicators CASCADE;
CREATE TABLE public.forex_indicators (
	base bigserial NOT NULL,
	quote bigserial NOT NULL,
	date date NOT NULL,
	CONSTRAINT forex_indicatros_base_quote_date_uq UNIQUE (base,quote,date)
);
-- ddl-end --
COMMENT ON TABLE public.forex_indicators IS E'Calculated indicators for forex pairs.';
-- ddl-end --
ALTER TABLE public.forex_indicators OWNER TO postgres;
-- ddl-end --

-- object: public.outstanding_shares | type: TABLE --
-- DROP TABLE IF EXISTS public.outstanding_shares CASCADE;
CREATE TABLE public.outstanding_shares (
	security bigint NOT NULL,
	date date NOT NULL,
	outstanding_shares bigint NOT NULL,
	CONSTRAINT outstanding_shares_security_date_uq UNIQUE (security,date)
);
-- ddl-end --
ALTER TABLE public.outstanding_shares OWNER TO postgres;
-- ddl-end --

-- object: securities_currency_id_currencies | type: CONSTRAINT --
-- ALTER TABLE public.securities DROP CONSTRAINT IF EXISTS securities_currency_id_currencies CASCADE;
ALTER TABLE public.securities ADD CONSTRAINT securities_currency_id_currencies FOREIGN KEY (currency)
REFERENCES public.currencies (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: securities_exchange_id | type: CONSTRAINT --
-- ALTER TABLE public.securities DROP CONSTRAINT IF EXISTS securities_exchange_id CASCADE;
ALTER TABLE public.securities ADD CONSTRAINT securities_exchange_id FOREIGN KEY (exchange)
REFERENCES public.exchanges (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: securities_gics_code | type: CONSTRAINT --
-- ALTER TABLE public.securities DROP CONSTRAINT IF EXISTS securities_gics_code CASCADE;
ALTER TABLE public.securities ADD CONSTRAINT securities_gics_code FOREIGN KEY (gics_code)
REFERENCES public.gics_codes (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: securities_country_fk | type: CONSTRAINT --
-- ALTER TABLE public.securities DROP CONSTRAINT IF EXISTS securities_country_fk CASCADE;
ALTER TABLE public.securities ADD CONSTRAINT securities_country_fk FOREIGN KEY (country)
REFERENCES public.countries (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: quotes_security_id_securities | type: CONSTRAINT --
-- ALTER TABLE public.quotes DROP CONSTRAINT IF EXISTS quotes_security_id_securities CASCADE;
ALTER TABLE public.quotes ADD CONSTRAINT quotes_security_id_securities FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: analyst_ratings_security_id_securities | type: CONSTRAINT --
-- ALTER TABLE public.analyst_ratings DROP CONSTRAINT IF EXISTS analyst_ratings_security_id_securities CASCADE;
ALTER TABLE public.analyst_ratings ADD CONSTRAINT analyst_ratings_security_id_securities FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: exchanges_country_fk | type: CONSTRAINT --
-- ALTER TABLE public.exchanges DROP CONSTRAINT IF EXISTS exchanges_country_fk CASCADE;
ALTER TABLE public.exchanges ADD CONSTRAINT exchanges_country_fk FOREIGN KEY (country)
REFERENCES public.countries (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: exchanges_currency_fk | type: CONSTRAINT --
-- ALTER TABLE public.exchanges DROP CONSTRAINT IF EXISTS exchanges_currency_fk CASCADE;
ALTER TABLE public.exchanges ADD CONSTRAINT exchanges_currency_fk FOREIGN KEY (currency)
REFERENCES public.currencies (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: earnings_security_id | type: CONSTRAINT --
-- ALTER TABLE public.earnings DROP CONSTRAINT IF EXISTS earnings_security_id CASCADE;
ALTER TABLE public.earnings ADD CONSTRAINT earnings_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: options_expirations_security_fk | type: CONSTRAINT --
-- ALTER TABLE public.option_expirations DROP CONSTRAINT IF EXISTS options_expirations_security_fk CASCADE;
ALTER TABLE public.option_expirations ADD CONSTRAINT options_expirations_security_fk FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: option_contracts_security_id | type: CONSTRAINT --
-- ALTER TABLE public.option_contracts DROP CONSTRAINT IF EXISTS option_contracts_security_id CASCADE;
ALTER TABLE public.option_contracts ADD CONSTRAINT option_contracts_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "iv_Security_id" | type: CONSTRAINT --
-- ALTER TABLE public.volatility DROP CONSTRAINT IF EXISTS "iv_Security_id" CASCADE;
ALTER TABLE public.volatility ADD CONSTRAINT "iv_Security_id" FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: dividends_security_id | type: CONSTRAINT --
-- ALTER TABLE public.dividends DROP CONSTRAINT IF EXISTS dividends_security_id CASCADE;
ALTER TABLE public.dividends ADD CONSTRAINT dividends_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: splits_security_id | type: CONSTRAINT --
-- ALTER TABLE public.splits DROP CONSTRAINT IF EXISTS splits_security_id CASCADE;
ALTER TABLE public.splits ADD CONSTRAINT splits_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: addresses_security_securities_fk | type: CONSTRAINT --
-- ALTER TABLE public.addresses DROP CONSTRAINT IF EXISTS addresses_security_securities_fk CASCADE;
ALTER TABLE public.addresses ADD CONSTRAINT addresses_security_securities_fk FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: addresses_country_countries_fq | type: CONSTRAINT --
-- ALTER TABLE public.addresses DROP CONSTRAINT IF EXISTS addresses_country_countries_fq CASCADE;
ALTER TABLE public.addresses ADD CONSTRAINT addresses_country_countries_fq FOREIGN KEY (country)
REFERENCES public.countries (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: base_currency_id | type: CONSTRAINT --
-- ALTER TABLE public.forex_pair_quotes DROP CONSTRAINT IF EXISTS base_currency_id CASCADE;
ALTER TABLE public.forex_pair_quotes ADD CONSTRAINT base_currency_id FOREIGN KEY (base)
REFERENCES public.currencies (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: quote_currency_id | type: CONSTRAINT --
-- ALTER TABLE public.forex_pair_quotes DROP CONSTRAINT IF EXISTS quote_currency_id CASCADE;
ALTER TABLE public.forex_pair_quotes ADD CONSTRAINT quote_currency_id FOREIGN KEY (quote)
REFERENCES public.currencies (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: annual_earnings_security_id | type: CONSTRAINT --
-- ALTER TABLE public.annual_earnings DROP CONSTRAINT IF EXISTS annual_earnings_security_id CASCADE;
ALTER TABLE public.annual_earnings ADD CONSTRAINT annual_earnings_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: insider_transactions_security_id | type: CONSTRAINT --
-- ALTER TABLE public.insider_transactions DROP CONSTRAINT IF EXISTS insider_transactions_security_id CASCADE;
ALTER TABLE public.insider_transactions ADD CONSTRAINT insider_transactions_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: etf_data_security_id | type: CONSTRAINT --
-- ALTER TABLE public.etf_data DROP CONSTRAINT IF EXISTS etf_data_security_id CASCADE;
ALTER TABLE public.etf_data ADD CONSTRAINT etf_data_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: etf_holdings_security_id | type: CONSTRAINT --
-- ALTER TABLE public.etf_holdings DROP CONSTRAINT IF EXISTS etf_holdings_security_id CASCADE;
ALTER TABLE public.etf_holdings ADD CONSTRAINT etf_holdings_security_id FOREIGN KEY (etf)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: etf_holdings_linked_security_id | type: CONSTRAINT --
-- ALTER TABLE public.etf_holdings DROP CONSTRAINT IF EXISTS etf_holdings_linked_security_id CASCADE;
ALTER TABLE public.etf_holdings ADD CONSTRAINT etf_holdings_linked_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: etf_holdings_gics_code_fk | type: CONSTRAINT --
-- ALTER TABLE public.etf_holdings DROP CONSTRAINT IF EXISTS etf_holdings_gics_code_fk CASCADE;
ALTER TABLE public.etf_holdings ADD CONSTRAINT etf_holdings_gics_code_fk FOREIGN KEY (gics_code)
REFERENCES public.gics_codes (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: etf_holdings_country_fk | type: CONSTRAINT --
-- ALTER TABLE public.etf_holdings DROP CONSTRAINT IF EXISTS etf_holdings_country_fk CASCADE;
ALTER TABLE public.etf_holdings ADD CONSTRAINT etf_holdings_country_fk FOREIGN KEY (country)
REFERENCES public.countries (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: balance_sheet_security_fk | type: CONSTRAINT --
-- ALTER TABLE public.balance_sheets DROP CONSTRAINT IF EXISTS balance_sheet_security_fk CASCADE;
ALTER TABLE public.balance_sheets ADD CONSTRAINT balance_sheet_security_fk FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: cash_flow_security_fk | type: CONSTRAINT --
-- ALTER TABLE public.cash_flows DROP CONSTRAINT IF EXISTS cash_flow_security_fk CASCADE;
ALTER TABLE public.cash_flows ADD CONSTRAINT cash_flow_security_fk FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: income_statement_security_fk | type: CONSTRAINT --
-- ALTER TABLE public.income_statements DROP CONSTRAINT IF EXISTS income_statement_security_fk CASCADE;
ALTER TABLE public.income_statements ADD CONSTRAINT income_statement_security_fk FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: officers_security_id | type: CONSTRAINT --
-- ALTER TABLE public.officers DROP CONSTRAINT IF EXISTS officers_security_id CASCADE;
ALTER TABLE public.officers ADD CONSTRAINT officers_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: exchange_holidays_exchanges_fk | type: CONSTRAINT --
-- ALTER TABLE public.exchange_holidays DROP CONSTRAINT IF EXISTS exchange_holidays_exchanges_fk CASCADE;
ALTER TABLE public.exchange_holidays ADD CONSTRAINT exchange_holidays_exchanges_fk FOREIGN KEY (exchange)
REFERENCES public.exchanges (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: option_contracts_last_security_id | type: CONSTRAINT --
-- ALTER TABLE public.option_contracts_last DROP CONSTRAINT IF EXISTS option_contracts_last_security_id CASCADE;
ALTER TABLE public.option_contracts_last ADD CONSTRAINT option_contracts_last_security_id FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: options_expirations_last_security_fk | type: CONSTRAINT --
-- ALTER TABLE public.option_expirations_last DROP CONSTRAINT IF EXISTS options_expirations_last_security_fk CASCADE;
ALTER TABLE public.option_expirations_last ADD CONSTRAINT options_expirations_last_security_fk FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: indicators_security_fk | type: CONSTRAINT --
-- ALTER TABLE public.indicators DROP CONSTRAINT IF EXISTS indicators_security_fk CASCADE;
ALTER TABLE public.indicators ADD CONSTRAINT indicators_security_fk FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: forex_indicators_base_fk | type: CONSTRAINT --
-- ALTER TABLE public.forex_indicators DROP CONSTRAINT IF EXISTS forex_indicators_base_fk CASCADE;
ALTER TABLE public.forex_indicators ADD CONSTRAINT forex_indicators_base_fk FOREIGN KEY (base)
REFERENCES public.currencies (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: forex_indicators_quote_fk | type: CONSTRAINT --
-- ALTER TABLE public.forex_indicators DROP CONSTRAINT IF EXISTS forex_indicators_quote_fk CASCADE;
ALTER TABLE public.forex_indicators ADD CONSTRAINT forex_indicators_quote_fk FOREIGN KEY (quote)
REFERENCES public.currencies (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: outstanding_shares_security_fk | type: CONSTRAINT --
-- ALTER TABLE public.outstanding_shares DROP CONSTRAINT IF EXISTS outstanding_shares_security_fk CASCADE;
ALTER TABLE public.outstanding_shares ADD CONSTRAINT outstanding_shares_security_fk FOREIGN KEY (security)
REFERENCES public.securities (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


