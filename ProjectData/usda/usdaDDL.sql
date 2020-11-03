--
-- USDA Food Database R18
--
BEGIN;

SET client_encoding = 'LATIN1';

--
-- Name: data_src; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE data_src (
    datasrc_id character(6) NOT NULL,
    authors text,
    title text NOT NULL,
    "year" integer,
    journal text,
    vol_city text,
    issue_state text,
    start_page text,
    end_page text
);


--
-- Name: datsrcln; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE datsrcln (
    ndb_no character(5) NOT NULL,
    nutr_no character(3) NOT NULL,
    datasrc_id character(6) NOT NULL
);


--
-- Name: deriv_cd; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deriv_cd (
    deriv_cd text NOT NULL,
    derivcd_desc text NOT NULL
);


--
-- Name: fd_group; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fd_group (
    fdgrp_cd character(4) NOT NULL,
    fddrp_desc text NOT NULL
);


--
-- Name: food_des; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE food_des (
    ndb_no character(5) NOT NULL,
    fdgrp_cd character(4) NOT NULL,
    long_desc text NOT NULL,
    shrt_desc text NOT NULL,
    comname text,
    manufacname text,
    survey character(1),
    ref_desc text,
    refuse integer,
    sciname text,
    n_factor double precision,
    pro_factor double precision,
    fat_factor double precision,
    cho_factor double precision
);


--
-- Name: footnote; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE footnote (
    ndb_no character(5) NOT NULL,
    footnt_no character(4) NOT NULL,
    footnt_typ character(1) NOT NULL,
    nutr_no character(3),
    footnt_txt text NOT NULL
);


--
-- Name: nut_data; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE nut_data (
    ndb_no character(5) NOT NULL,
    nutr_no character(3) NOT NULL,
    nutr_val double precision NOT NULL,
    num_data_pts double precision NOT NULL,
    std_error double precision,
    src_cd integer NOT NULL,
    deriv_cd text,
    ref_ndb_no character(5),
    add_nutr_mark character(1),
    num_studies integer,
    min double precision,
    max double precision,
    df integer,
    low_eb double precision,
    up_eb double precision,
    stat_cmt text,
    cc character(1)
);


--
-- Name: nutr_def; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE nutr_def (
    nutr_no character(3) NOT NULL,
    units text NOT NULL,
    tagname text,
    nutrdesc text,
    num_dec smallint,
    sr_order integer
);


--
-- Name: src_cd; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE src_cd (
    src_cd integer NOT NULL,
    srccd_desc text NOT NULL
);


--
-- Name: weight; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE weight (
    ndb_no character(5) NOT NULL,
    seq character(2) NOT NULL,
    amount double precision NOT NULL,
    msre_desc text NOT NULL,
    gm_wgt double precision NOT NULL,
    num_data_pts integer,
    std_dev double precision
);



--
-- Name: data_src_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY data_src
    ADD CONSTRAINT data_src_pkey PRIMARY KEY (datasrc_id);


--
-- Name: datsrcln_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY datsrcln
    ADD CONSTRAINT datsrcln_pkey PRIMARY KEY (ndb_no, nutr_no, datasrc_id);


--
-- Name: deriv_cd_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY deriv_cd
    ADD CONSTRAINT deriv_cd_pkey PRIMARY KEY (deriv_cd);


--
-- Name: fd_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fd_group
    ADD CONSTRAINT fd_group_pkey PRIMARY KEY (fdgrp_cd);


--
-- Name: food_des_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY food_des
    ADD CONSTRAINT food_des_pkey PRIMARY KEY (ndb_no);


--
-- Name: nut_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_pkey PRIMARY KEY (ndb_no, nutr_no);


--
-- Name: nutr_def_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY nutr_def
    ADD CONSTRAINT nutr_def_pkey PRIMARY KEY (nutr_no);


--
-- Name: src_cd_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY src_cd
    ADD CONSTRAINT src_cd_pkey PRIMARY KEY (src_cd);


--
-- Name: weight_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY weight
    ADD CONSTRAINT weight_pkey PRIMARY KEY (ndb_no, seq);


--
-- Name: datsrcln_datasrc_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX datsrcln_datasrc_id_idx ON datsrcln USING btree (datasrc_id);


--
-- Name: food_des_fdgrp_cd_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX food_des_fdgrp_cd_idx ON food_des USING btree (fdgrp_cd);


--
-- Name: footnote_ndb_no_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX footnote_ndb_no_idx ON footnote USING btree (ndb_no, nutr_no);


--
-- Name: nut_data_deriv_cd_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX nut_data_deriv_cd_idx ON nut_data USING btree (deriv_cd);


--
-- Name: nut_data_nutr_no_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX nut_data_nutr_no_idx ON nut_data USING btree (nutr_no);


--
-- Name: nut_data_src_cd_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX nut_data_src_cd_idx ON nut_data USING btree (src_cd);


--
-- Name: datsrcln_datasrc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY datsrcln
    ADD CONSTRAINT datsrcln_datasrc_id_fkey FOREIGN KEY (datasrc_id) REFERENCES data_src(datasrc_id);


--
-- Name: datsrcln_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY datsrcln
    ADD CONSTRAINT datsrcln_ndb_no_fkey FOREIGN KEY (ndb_no, nutr_no) REFERENCES nut_data(ndb_no, nutr_no);


--
-- Name: food_des_fdgrp_cd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY food_des
    ADD CONSTRAINT food_des_fdgrp_cd_fkey FOREIGN KEY (fdgrp_cd) REFERENCES fd_group(fdgrp_cd);


--
-- Name: footnote_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY footnote
    ADD CONSTRAINT footnote_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES food_des(ndb_no);


--
-- Name: footnote_nutr_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY footnote
    ADD CONSTRAINT footnote_nutr_no_fkey FOREIGN KEY (nutr_no) REFERENCES nutr_def(nutr_no);


--
-- Name: nut_data_deriv_cd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_deriv_cd_fkey FOREIGN KEY (deriv_cd) REFERENCES deriv_cd(deriv_cd);


--
-- Name: nut_data_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES food_des(ndb_no);


--
-- Name: nut_data_nutr_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_nutr_no_fkey FOREIGN KEY (nutr_no) REFERENCES nutr_def(nutr_no);


--
-- Name: nut_data_src_cd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_src_cd_fkey FOREIGN KEY (src_cd) REFERENCES src_cd(src_cd);


--
-- Name: weight_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY weight
    ADD CONSTRAINT weight_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES food_des(ndb_no);

COMMIT;

--
-- PostgreSQL database dump complete
--

ANALYZE;
